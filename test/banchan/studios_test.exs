defmodule Banchan.StudiosTest do
  @moduledoc """
  Tests for Studios-related functionality.
  """
  use Banchan.DataCase

  import Mox

  import Banchan.AccountsFixtures
  import Banchan.CommissionsFixtures
  import Banchan.StudiosFixtures

  alias Banchan.Commissions
  alias Banchan.Commissions.Invoice
  alias Banchan.Notifications
  alias Banchan.Repo
  alias Banchan.Studios
  alias Banchan.Studios.{Payout, Studio}

  setup :verify_on_exit!

  describe "validation" do
    test "cannot use an existing handle" do
      user = user_fixture()
      existing_studio = studio_fixture([user])

      changeset =
        Studio.profile_changeset(
          %Studio{},
          %{name: "valid name", handle: existing_studio.handle}
        )

      refute changeset.valid?
    end

    test "cannot use an existing user handle" do
      user = user_fixture()

      changeset =
        Studio.profile_changeset(
          %Studio{},
          %{name: "valid name", handle: user.handle}
        )

      refute changeset.valid?
    end
  end

  describe "creation" do
    test "create and enable a studio" do
      user = user_fixture()
      stripe_id = unique_stripe_id()
      studio_handle = unique_studio_handle()
      studio_name = unique_studio_name()
      studio_url = "http://localhost:4000/studios/#{studio_handle}"

      Banchan.StripeAPI.Mock
      |> expect(:create_account, fn attrs ->
        assert "express" == attrs.type
        assert %{payouts: %{schedule: %{interval: "manual"}}} == attrs.settings
        assert studio_url == attrs.business_profile.url
        {:ok, %Stripe.Account{id: stripe_id}}
      end)

      {:ok, studio} =
        Banchan.Studios.new_studio(
          %Studio{artists: [user]},
          studio_url,
          %{
            name: studio_name,
            handle: studio_handle
          }
        )

      assert studio.stripe_id == stripe_id
      assert studio.handle == studio_handle
      assert studio.name == studio_name

      Repo.transaction(fn ->
        subscribers =
          studio
          |> Notifications.studio_subscribers()
          |> Enum.map(& &1.id)

        assert subscribers == [user.id]
      end)
    end
  end

  describe "updating" do
    test "update studio profile" do
      user = user_fixture()
      studio = studio_fixture([user])

      attrs = %{
        name: "new name",
        handle: "new-handle",
        description: "new description",
        summary: "new summary",
        default_terms: "new terms",
        default_template: "new template"
      }

      {:error, :unauthorized} =
        Studios.update_studio_profile(
          studio,
          false,
          attrs
        )

      from_db = Repo.get!(Studio, studio.id) |> Repo.preload(:artists)
      assert from_db.name != attrs.name

      {:ok, studio} =
        Studios.update_studio_profile(
          studio,
          true,
          attrs
        )

      assert studio.name == "new name"
      assert studio.handle == "new-handle"
      assert studio.description == "new description"
      assert studio.summary == "new summary"
      assert studio.default_terms == "new terms"
      assert studio.default_template == "new template"

      from_db = Repo.get!(Studio, studio.id) |> Repo.preload(:artists)
      assert studio.name == from_db.name
      assert studio.handle == from_db.handle
      assert studio.description == from_db.description
      assert studio.summary == from_db.summary
      assert studio.default_terms == from_db.default_terms
      assert studio.default_template == from_db.default_template
    end

    test "update_stripe_state" do
      user = user_fixture()
      studio = studio_fixture([user])
      Studios.subscribe_to_stripe_state(studio)

      Studios.update_stripe_state(studio.stripe_id, %Stripe.Account{
        charges_enabled: true,
        details_submitted: true
      })

      from_db = Repo.get!(Studio, studio.id)
      assert from_db.stripe_charges_enabled == true
      assert from_db.stripe_details_submitted == true

      topic = "studio_stripe_state:#{studio.stripe_id}"

      assert_receive %Phoenix.Socket.Broadcast{
        topic: ^topic,
        event: "charges_state_changed",
        payload: true
      }

      assert_receive %Phoenix.Socket.Broadcast{
        topic: ^topic,
        event: "details_submitted_changed",
        payload: true
      }

      Studios.unsubscribe_from_stripe_state(studio)
    end
  end

  describe "listing" do
    test "list all studios" do
      user = user_fixture()
      studio = studio_fixture([user])

      assert studio.id in Enum.map(Studios.list_studios(), & &1.id)
    end

    test "list user studios and studio members" do
      user = user_fixture()
      studio_handle = unique_studio_handle()
      studio_name = unique_studio_name()
      studio_url = "http://localhost:4000/studios/#{studio_handle}"

      Banchan.StripeAPI.Mock
      |> expect(:create_account, fn _ ->
        {:ok, %Stripe.Account{id: unique_stripe_id()}}
      end)

      {:ok, studio} =
        Banchan.Studios.new_studio(
          %Studio{artists: [user]},
          studio_url,
          valid_studio_attributes(%{
            name: studio_name,
            handle: studio_handle
          })
        )

      assert Enum.map(Studios.list_studios_for_user(user), & &1.id) == [studio.id]
      assert Enum.map(Studios.list_studio_members(studio), & &1.id) == [user.id]
      assert Studios.is_user_in_studio?(user, studio)
    end
  end

  describe "onboarding" do
    test "create onboarding link" do
      user = user_fixture()
      studio = studio_fixture([user])
      link_url = "http://link_url"

      Banchan.StripeAPI.Mock
      |> expect(:create_account_link, fn params ->
        assert %{
                 account: studio.stripe_id,
                 type: "account_onboarding",
                 return_url: "http://url1",
                 refresh_url: "http://url2"
               } == params

        {:ok, %Stripe.AccountLink{url: link_url}}
      end)

      assert Studios.get_onboarding_link!(studio, "http://url1", "http://url2") == link_url
    end
  end

  describe "charges and payouts" do
    test "charges_enabled?" do
      user = user_fixture()
      studio = studio_fixture([user])

      Studios.update_stripe_state(studio.stripe_id, %Stripe.Account{
        charges_enabled: true
      })

      Banchan.StripeAPI.Mock
      |> expect(:retrieve_account, fn _ ->
        {:ok, %Stripe.Account{charges_enabled: true}}
      end)

      assert !Studios.charges_enabled?(studio)
      assert Studios.charges_enabled?(studio, true)
    end

    test "basic payout" do
      commission = commission_fixture()
      client = commission.client
      studio = commission.studio
      amount = Money.new(420, :USD)
      tip = Money.new(69, :USD)

      banchan_fee =
        amount
        |> Money.add(tip)
        |> Money.multiply(studio.platform_fee)

      net =
        amount
        |> Money.add(tip)
        |> Money.subtract(banchan_fee)
        |> Money.multiply(2)

      # Two successful invoices and one expired one
      invoice =
        invoice_fixture(client, commission, %{
          "amount" => amount,
          "text" => "please give me money :("
        })

      sess = checkout_session_fixture(invoice, tip)
      succeed_mock_payment!(sess)

      invoice =
        invoice_fixture(client, commission, %{
          "amount" => amount,
          "text" => "please give me money :("
        })

      sess = checkout_session_fixture(invoice, tip)
      succeed_mock_payment!(sess)

      invoice =
        invoice_fixture(client, commission, %{
          "amount" => Money.new(10_000, :USD),
          "text" => "please give me money :("
        })

      Commissions.expire_payment!(invoice, true)

      Banchan.StripeAPI.Mock
      |> expect(:retrieve_balance, 4, fn opts ->
        assert %{"Stripe-Account" => studio.stripe_id} == Keyword.get(opts, :headers)

        {:ok,
         %Stripe.Balance{
           available: [
             %{
               currency: "usd",
               amount: net.amount
             }
           ],
           pending: [
             %{
               currency: "usd",
               amount: 0
             }
           ]
         }}
      end)

      balance = Studios.get_banchan_balance!(studio)

      assert [net] == balance.stripe_available
      assert [Money.new(0, :USD)] == balance.stripe_pending
      assert [net] == balance.held_back
      assert [] == balance.released
      assert [] == balance.on_the_way
      assert [] == balance.paid
      assert [] == balance.failed
      assert [] == balance.available

      assert {:ok, [Money.new(0, :USD)]} == Studios.payout_studio(studio)

      {:ok, _} = Commissions.update_status(client, commission |> Repo.reload(), :accepted)
      {:ok, _} = Commissions.update_status(client, commission |> Repo.reload(), :ready_for_review)
      {:ok, _} = Commissions.update_status(client, commission |> Repo.reload(), :approved)

      stripe_payout_id = "stripe_payout_id#{System.unique_integer()}"

      Banchan.StripeAPI.Mock
      |> expect(:create_payout, fn params, opts ->
        assert %{"Stripe-Account" => studio.stripe_id} == Keyword.get(opts, :headers)

        assert %{
                 amount: net.amount,
                 currency: "usd",
                 statement_descriptor: "banchan.art payout"
               } == params

        {:ok, %Stripe.Payout{id: stripe_payout_id, status: "pending"}}
      end)

      assert {:ok, [net]} == Studios.payout_studio(studio)

      payout = from(p in Payout, where: p.studio_id == ^studio.id) |> Repo.one!()

      paid_invoices =
        from(i in Invoice, where: i.commission_id == ^commission.id and i.status == :succeeded)
        |> Repo.all()

      assert Enum.all?(paid_invoices, &(&1.payout_id == payout.id))

      expired_invoices =
        from(i in Invoice, where: i.commission_id == ^commission.id and i.status == :expired)
        |> Repo.all()

      assert Enum.all?(expired_invoices, &is_nil(&1.payout_id))

      # Payout funds are marked as on_the_way until we get notified by stripe
      # that the payment has been completed.
      balance = Studios.get_banchan_balance!(studio)

      assert [net] == balance.stripe_available
      assert [Money.new(0, :USD)] == balance.stripe_pending
      assert [] == balance.held_back
      assert [] == balance.released
      assert [net] == balance.on_the_way
      assert [] == balance.paid
      assert [] == balance.failed
      assert [] == balance.available

      Banchan.StripeAPI.Mock
      |> expect(:retrieve_balance, 1, fn opts ->
        assert %{"Stripe-Account" => studio.stripe_id} == Keyword.get(opts, :headers)

        {:ok,
         %Stripe.Balance{
           available: [
             %{
               currency: "usd",
               amount: 0
             }
           ],
           pending: [
             %{
               currency: "usd",
               amount: 0
             }
           ]
         }}
      end)

      Studios.process_payout_updated!(%Stripe.Payout{
        id: payout.stripe_payout_id,
        status: "paid",
        failure_code: nil,
        failure_message: nil
      })

      balance = Studios.get_banchan_balance!(studio)

      assert [Money.new(0, :USD)] == balance.stripe_available
      assert [Money.new(0, :USD)] == balance.stripe_pending
      assert [] == balance.held_back
      assert [] == balance.released
      assert [] == balance.on_the_way
      assert [net] == balance.paid
      assert [] == balance.failed
      assert [] == balance.available
    end

    test "stripe pending vs released -> available" do
      commission = commission_fixture()
      client = commission.client
      studio = commission.studio
      amount = Money.new(420, :USD)
      tip = Money.new(69, :USD)

      banchan_fee =
        amount
        |> Money.add(tip)
        |> Money.multiply(studio.platform_fee)

      net =
        amount
        |> Money.add(tip)
        |> Money.subtract(banchan_fee)

      invoice =
        invoice_fixture(client, commission, %{
          "amount" => amount,
          "text" => "please give me money :("
        })

      sess = checkout_session_fixture(invoice, tip)
      succeed_mock_payment!(sess)

      Banchan.StripeAPI.Mock
      |> expect(:retrieve_balance, 4, fn opts ->
        assert %{"Stripe-Account" => studio.stripe_id} == Keyword.get(opts, :headers)

        {:ok,
         %Stripe.Balance{
           available: [
             %{
               currency: "usd",
               amount: 0
             }
           ],
           # We've "released" funds from the commission, but the funds are
           # still pending their waiting period on stripe.
           pending: [
             %{
               currency: "usd",
               amount: net.amount
             }
           ]
         }}
      end)

      balance = Studios.get_banchan_balance!(studio)

      assert [Money.new(0, :USD)] == balance.stripe_available
      assert [net] == balance.stripe_pending
      assert [net] == balance.held_back
      assert [] == balance.released
      assert [] == balance.on_the_way
      assert [] == balance.paid
      assert [] == balance.failed
      assert [] == balance.available

      assert {:ok, [Money.new(0, :USD)]} == Studios.payout_studio(studio)

      {:ok, _} = Commissions.update_status(client, commission |> Repo.reload(), :accepted)
      {:ok, _} = Commissions.update_status(client, commission |> Repo.reload(), :ready_for_review)
      {:ok, _} = Commissions.update_status(client, commission |> Repo.reload(), :approved)

      # No money available on Stripe yet, so no payout happens.
      assert {:ok, [Money.new(0, :USD)]} == Studios.payout_studio(studio)

      balance = Studios.get_banchan_balance!(studio)

      assert [Money.new(0, :USD)] == balance.stripe_available
      assert [net] == balance.stripe_pending
      assert [] == balance.held_back
      assert [net] == balance.released
      assert [] == balance.on_the_way
      assert [] == balance.paid
      assert [] == balance.failed

      # This might be a bit weird, but it's fine, and we should always account for this case anyway.
      assert [Money.new(0, :USD)] == balance.available

      # Make them available!
      Banchan.StripeAPI.Mock
      |> expect(:retrieve_balance, 1, fn opts ->
        assert %{"Stripe-Account" => studio.stripe_id} == Keyword.get(opts, :headers)

        {:ok,
         %Stripe.Balance{
           available: [
             %{
               currency: "usd",
               amount: net.amount
             }
           ],
           # We've "released" funds from the commission, but the funds are
           # still pending their waiting period on stripe.
           pending: [
             %{
               currency: "usd",
               amount: 0
             }
           ]
         }}
      end)

      # Payout funds are marked as on_the_way until we get notified by stripe
      # that the payment has been completed.
      balance = Studios.get_banchan_balance!(studio)

      assert [net] == balance.stripe_available
      assert [Money.new(0, :USD)] == balance.stripe_pending
      assert [] == balance.held_back
      assert [net] == balance.released
      assert [] == balance.on_the_way
      assert [] == balance.paid
      assert [] == balance.failed
      assert [net] == balance.available
    end

    test "immediate failed payout" do
      commission = commission_fixture()
      client = commission.client
      studio = commission.studio
      amount = Money.new(420, :USD)
      tip = Money.new(69, :USD)

      banchan_fee =
        amount
        |> Money.add(tip)
        |> Money.multiply(studio.platform_fee)

      net =
        amount
        |> Money.add(tip)
        |> Money.subtract(banchan_fee)

      invoice =
        invoice_fixture(client, commission, %{
          "amount" => amount,
          "text" => "please give me money :("
        })

      sess = checkout_session_fixture(invoice, tip)
      succeed_mock_payment!(sess)

      Banchan.StripeAPI.Mock
      |> expect(:retrieve_balance, 2, fn opts ->
        assert %{"Stripe-Account" => studio.stripe_id} == Keyword.get(opts, :headers)

        {:ok,
         %Stripe.Balance{
           available: [
             %{
               currency: "usd",
               amount: net.amount
             }
           ],
           pending: [
             %{
               currency: "usd",
               amount: 0
             }
           ]
         }}
      end)

      {:ok, _} = Commissions.update_status(client, commission |> Repo.reload(), :accepted)
      {:ok, _} = Commissions.update_status(client, commission |> Repo.reload(), :ready_for_review)
      {:ok, _} = Commissions.update_status(client, commission |> Repo.reload(), :approved)

      stripe_err = %Stripe.Error{
        source: %{},
        code: :amount_too_large,
        message: "Log me?",
        user_message: "Oops, something went wrong with your payout :("
      }

      Banchan.StripeAPI.Mock
      |> expect(:create_payout, fn _, _ ->
        # TODO: What are the actual possible value here? Need to test by hand. Sigh.
        # TODO: Assert that we're actually logging a message here
        {:error, stripe_err}
      end)

      assert {:error, stripe_err} == Studios.payout_studio(studio)

      assert [] == from(p in Payout, where: p.studio_id == ^studio.id) |> Repo.all()

      paid_invoices =
        from(i in Invoice, where: i.commission_id == ^commission.id and i.status == :succeeded)
        |> Repo.all()

      assert Enum.all?(paid_invoices, &is_nil(&1.payout_id))

      expired_invoices =
        from(i in Invoice, where: i.commission_id == ^commission.id and i.status == :expired)
        |> Repo.all()

      assert Enum.all?(expired_invoices, &is_nil(&1.payout_id))

      # We don't mark them as failed when the failure was immediate. They just
      # stay "released".
      balance = Studios.get_banchan_balance!(studio)

      assert [net] == balance.stripe_available
      assert [Money.new(0, :USD)] == balance.stripe_pending
      assert [] == balance.held_back
      assert [net] == balance.released
      assert [] == balance.on_the_way
      assert [] == balance.paid
      assert [] == balance.failed
      assert [net] == balance.available
    end
  end
end
