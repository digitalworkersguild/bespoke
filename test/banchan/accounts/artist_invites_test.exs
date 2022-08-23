defmodule Banchan.AccountsTest.ArtistInvites do
  @moduledoc """
  Test for functionality related to artist invite tokens.
  """
  use Banchan.DataCase, async: true

  import Banchan.AccountsFixtures

  alias Banchan.Accounts
  alias Banchan.Accounts.InviteRequest

  describe "list_invite_requests/1" do
  end

  describe "add_invite_request" do
    test "inserts a new invite request" do
      email = "foo@example.com"

      assert {:ok, %InviteRequest{id: request_id, email: ^email, token_id: nil}} =
               Accounts.add_invite_request(email)

      assert [%InviteRequest{id: ^request_id}] = Accounts.list_invite_requests().entries
    end

    test "validates the email" do
      assert {:error, changeset} = Accounts.add_invite_request("badmail")

      assert %{email: ["must have the @ sign and no spaces"]} = errors_on(changeset)
    end

    test "allows duplicates" do
      email = "foo@example.com"

      assert {:ok, %InviteRequest{id: request_id_1, email: ^email, token_id: nil}} =
               Accounts.add_invite_request(email)

      assert [%InviteRequest{id: ^request_id_1}] = Accounts.list_invite_requests().entries

      assert {:ok, %InviteRequest{id: request_id_2, email: ^email, token_id: nil}} =
               Accounts.add_invite_request(email)

      assert [%InviteRequest{id: ^request_id_1}, %InviteRequest{id: ^request_id_2}] =
               Accounts.list_invite_requests().entries
    end

    test "accepts an optional argument to specify a custom inserted_at timestamp" do
      timestamp =
        NaiveDateTime.utc_now()
        |> NaiveDateTime.add(-1 * 60 * 60 * 24)
        |> NaiveDateTime.truncate(:second)

      assert {:ok, %InviteRequest{inserted_at: ^timestamp}} =
               Accounts.add_invite_request("foo@example.com", timestamp)

      assert [%InviteRequest{inserted_at: ^timestamp}] = Accounts.list_invite_requests().entries
    end
  end

  describe "send_invite/3" do
  end

  describe "generate_artist_token/1" do
  end

  describe "apply_artist_token/2" do
  end
end