defmodule BanchanWeb.CommissionLive.Components.StatusBox do
  @moduledoc """
  Action box that changes behavior based on the commission's status.
  """
  use BanchanWeb, :live_component

  alias Banchan.Commissions
  alias Banchan.Payments

  alias BanchanWeb.Components.{
    Button,
    Collapse,
    Dropdown,
    DropdownItem,
    Modal
  }

  prop(current_user, :struct, from_context: :current_user)
  prop(current_user_member?, :boolean, from_context: :current_user_member?)
  prop(commission, :struct, from_context: :commission)

  data(invoices_paid?, :boolean)
  data(statuses, :list)

  def update(assigns, socket) do
    socket = assign(socket, assigns)

    invoices = Payments.list_invoices(commission: socket.assigns.commission)

    invoices_paid? =
      !Enum.empty?(invoices) &&
        Enum.all?(invoices, &Payments.invoice_finished?(&1)) &&
        Enum.any?(invoices, &Payments.invoice_paid?(&1))

    {:ok,
     socket
     |> assign(
       invoices_paid?: invoices_paid?,
       statuses:
         Commissions.Common.status_values()
         |> Enum.filter(fn status ->
           status not in [:withdrawn, :ready_for_review, :approved] &&
             Commissions.status_transition_allowed?(
               socket.assigns.current_user_member?,
               socket.assigns.current_user.id == socket.assigns.commission.client_id,
               socket.assigns.commission.status,
               status
             )
         end)
     )}
  end

  def handle_event("update_status", %{"value" => "rejected"}, socket) do
    if Commissions.commission_active?(socket.assigns.commission) do
      Modal.show(socket.assigns.id <> "-reject-modal")
      {:noreply, socket}
    else
      update_status("rejected", socket)
    end
  end

  def handle_event("update_status", %{"value" => status}, socket) do
    update_status(status, socket)
  end

  def handle_event("confirm_reject", _, socket) do
    ret = update_status("rejected", socket)
    Modal.hide(socket.assigns.id <> "-reject-modal")
    ret
  end

  defp update_status(status, socket) do
    case Commissions.update_status(socket.assigns.current_user, socket.assigns.commission, status) do
      {:ok, _} ->
        Collapse.set_open(socket.assigns.id <> "-approval-collapse", false)
        Collapse.set_open(socket.assigns.id <> "-review-confirm-collapse", false)
        {:noreply, socket}

      {:error, :blocked} ->
        {:noreply,
         socket
         |> put_flash(:error, "You are blocked from further interaction with this studio.")
         |> push_navigate(
           to: Routes.commission_path(Endpoint, :show, socket.assigns.commission.public_id)
         )}
    end
  end

  def render(assigns) do
    has_transitions? = !Enum.empty?(assigns.statuses)

    ~F"""
    <div class="flex flex-col gap-2 w-full bg-base-200 rounded-box p-4 border-base-300 border-2">
      <h3 class="text-lg font-medium">Commission Status</h3>
      {#if has_transitions?}
        <Dropdown
          show_caret?
          class="btn btn-primary w-full"
          label={Commissions.Common.humanize_status(@commission.status)}
        >
          {#for status <- @statuses}
            <DropdownItem class="w-full">
              <button class="w-full" :on-click="update_status" value={status}>
                <div class="flex flex-col items-start w-full">
                  <span>{Commissions.Common.humanize_status(status)}</span>
                  <span class="text-xs text-base-content text-left opacity-50">
                    {Commissions.Common.status_description(status)}
                  </span>
                </div>
              </button>
            </DropdownItem>
          {/for}
        </Dropdown>
      {#else}
        <Button disabled label={Commissions.Common.humanize_status(@commission.status)} />
      {/if}
      <div class="text-md">
        {Commissions.Common.status_description(@commission.status)}
      </div>

      <Modal id={@id <> "-reject-modal"} class="reject-modal">
        <:title>Confirm Rejection</:title>
        Are you sure you want to reject this commission after accepting it?
        <p class="font-bold text-warning">
          NOTE: Any unreleased deposits will be canceled or refunded.
        </p>
        <:action>
          <Button class="reject-btn" click="confirm_reject">Confirm</Button>
        </:action>
      </Modal>
    </div>
    """
  end
end
