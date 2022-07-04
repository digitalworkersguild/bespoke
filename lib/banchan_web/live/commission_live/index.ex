defmodule BanchanWeb.CommissionLive do
  @moduledoc """
  Artist dashboard
  """
  use BanchanWeb, :surface_view

  alias Surface.Components.Form
  alias Surface.Components.Form.{Field, Submit}
  alias Surface.Components.Form.TextInput, as: SurfaceTextInput

  alias Banchan.{Accounts, Commissions, Studios}
  alias Banchan.Commissions.CommissionFilter

  alias BanchanWeb.CommissionLive.Components.CommissionRow
  alias BanchanWeb.Components.{Collapse, InfiniteScroll, Layout}
  alias BanchanWeb.Components.Form.{Checkbox, MultipleSelect, TextInput}

  alias BanchanWeb.CommissionLive.Components.Commission

  @status_options [
    {"Any", nil}
    | Commissions.Common.status_values()
      |> Enum.map(&{Commissions.Common.humanize_status(&1), &1})
  ]

  @impl true
  def handle_params(params, uri, socket) do
    socket =
      socket
      |> assign(
        :filter,
        Map.get(socket.assigns, :filter, CommissionFilter.changeset(%CommissionFilter{}))
      )

    socket =
      socket
      |> assign(page: 1)
      |> assign(status_options: @status_options)
      |> assign(filter_open: Map.get(socket.assigns, :filter_open, false))
      |> assign(
        :results,
        Commissions.list_commission_data_for_dashboard(
          socket.assigns.current_user,
          Ecto.Changeset.apply_changes(socket.assigns.filter),
          1
        )
      )

    socket =
      case params do
        %{"commission_id" => commission_id} ->
          # NOTE: Phoenix LiveView's push_patch has an obnoxious bug with fragments, so
          # we have to manually remove them here.
          # See: https://github.com/phoenixframework/phoenix_live_view/issues/2041
          commission_id = Regex.replace(~r/#.*$/, commission_id, "")

          comm =
            if Map.has_key?(socket.assigns, :commission) && socket.assigns.commission &&
                 socket.assigns.commission.public_id == commission_id do
              socket.assigns.commission
            else
              if Map.has_key?(socket.assigns, :commission) && socket.assigns.commission do
                Commissions.unsubscribe_from_commission_events(socket.assigns.commission)
              end

              Commissions.get_commission!(
                commission_id,
                socket.assigns.current_user
              )
            end

          Commissions.subscribe_to_commission_events(comm)

          users =
            comm.events
            |> Enum.reduce(%{}, fn ev, acc ->
              if Map.has_key?(acc, ev.actor_id) do
                acc
              else
                Map.put(acc, ev.actor_id, Accounts.get_user!(ev.actor_id))
              end
            end)

          assign(socket,
            commission: comm,
            users: users,
            current_user_member?:
              Studios.is_user_in_studio?(socket.assigns.current_user, %Studios.Studio{
                id: comm.studio_id
              })
          )

        _ ->
          assign(socket, commission: nil, users: %{}, current_user_member?: false)
      end

    {:noreply, socket |> assign(:uri, uri)}
  end

  @impl true
  def handle_info(%{event: "new_events", payload: events}, socket) do
    # TODO: I don't know why, but we sometimes get two `new_events` messages
    # for a single event addition. So we have to dedup here just in case until
    # that bug is... fixed? If it's even a bug vs something expected?
    # events = events |> Enum.map(& Repo.preload(&1, [:actor]))
    events = socket.assigns.commission.events ++ events

    users =
      events
      |> Enum.reduce(socket.assigns.users, fn ev, acc ->
        if Map.has_key?(acc, ev.actor_id) do
          acc
        else
          Map.put(acc, ev.actor_id, Accounts.get_user!(ev.actor_id))
        end
      end)

    events =
      events
      |> Enum.dedup_by(& &1.public_id)
      |> Enum.sort(&(Timex.diff(&1.inserted_at, &2.inserted_at) < 0))

    commission = %{socket.assigns.commission | events: events}
    Commission.events_updated("commission")
    {:noreply, assign(socket, users: users, commission: commission)}
  end

  def handle_info(%{event: "new_status", payload: status}, socket) do
    commission = %{socket.assigns.commission | status: status}
    {:noreply, assign(socket, commission: commission)}
  end

  def handle_info(%{event: "event_updated", payload: event}, socket) do
    events =
      socket.assigns.commission.events
      |> Enum.map(fn ev ->
        if ev.id == event.id do
          event
        else
          ev
        end
      end)

    commission = %{socket.assigns.commission | events: events}
    Commission.events_updated("commission")
    {:noreply, assign(socket, commission: commission)}
  end

  def handle_info(%{event: "line_items_changed", payload: line_items}, socket) do
    {:noreply,
     socket |> assign(commission: %{socket.assigns.commission | line_items: line_items})}
  end

  @impl true
  def handle_event("filter", %{"commission_filter" => filter}, socket) do
    changeset = CommissionFilter.changeset(%CommissionFilter{}, filter)

    socket =
      if changeset.valid? do
        socket
        |> assign(page: 1)
        |> assign(
          :results,
          Commissions.list_commission_data_for_dashboard(
            socket.assigns.current_user,
            Ecto.Changeset.apply_changes(changeset),
            1
          )
        )
      else
        socket
      end

    {:noreply, assign(socket, filter: changeset)}
  end

  def handle_event("toggle_filter", _, socket) do
    Collapse.set_open("filter-options", !socket.assigns.filter_open)
    {:noreply, assign(socket, filter_open: !socket.assigns.filter_open)}
  end

  def handle_event("load_more", _, socket) do
    if socket.assigns.results.total_entries >
         socket.assigns.page * socket.assigns.results.page_size do
      {:noreply, socket |> assign(page: socket.assigns.page + 1) |> fetch()}
    else
      {:noreply, socket}
    end
  end

  defp fetch(%{assigns: %{results: results, page: page, filter: changeset}} = socket) do
    socket
    |> assign(
      :results,
      %{
        results
        | entries:
            results.entries ++
              Commissions.list_commission_data_for_dashboard(
                socket.assigns.current_user,
                Ecto.Changeset.apply_changes(changeset),
                page
              ).entries
      }
    )
  end

  @impl true
  def render(assigns) do
    ~F"""
    <Layout uri={@uri} padding={0} current_user={@current_user} flashes={@flash}>
      <div class="flex flex-row grow xl:grow-0">
        <div class={"flex flex-col pt-4 sidebar basis-full", hidden: @commission}>
          <Form for={@filter} submit="filter" class="form-control px-4">
            <Field class="w-full input-group" name={:search}>
              <button :on-click="toggle_filter" type="button" class="btn btn-square btn-primary"><i class="fas fa-filter" /></button>
              <SurfaceTextInput class="input input-bordered w-full" />
              <Submit class="btn btn-square btn-primary">
                <i class="fas fa-search" />
              </Submit>
            </Field>
            <Collapse id="filter-options" class="rounded-box">
              <h2 class="text-xl pt-4">
                Additional Filters
              </h2>
              <div class="divider" />
              <TextInput name={:client} />
              <TextInput name={:studio} />
              <MultipleSelect name={:statuses} options={@status_options} />
              <div class="py-2">
                <Checkbox label="Show Archived" name={:show_archived} />
              </div>
              <Submit label="Apply" class="btn btn-square btn-primary w-full" />
            </Collapse>
          </Form>
          <div class="divider">Commissions</div>
          <ul class="menu menu-compact gap-2 p-2">
            {#for result <- @results.entries}
              <CommissionRow
                result={result}
                highlight={@commission && @commission.public_id == result.commission.public_id}
              />
            {#else}
              <li>
                <div class="py-2 px-4 text-xl">
                  No Results
                </div>
              </li>
            {/for}
          </ul>
          <InfiniteScroll id="commissions-infinite-scroll" page={@page} load_more="load_more" />
        </div>
        {#if @commission}
          <div class="basis-full">
            <Commission
              id="commission"
              uri={@uri}
              users={@users}
              current_user={@current_user}
              commission={@commission}
              current_user_member?={@current_user_member?}
            />
          </div>
        {/if}
      </div>
    </Layout>
    """
  end
end
