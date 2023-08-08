defmodule BanchanWeb.StudioLive.Components.FeaturedToggle do
  @moduledoc """
  Dedicated toggle for managing whether a studio appears in the carousel and
  other featured locations.
  """
  use BanchanWeb, :live_component

  alias Banchan.Studios
  alias Banchan.Studios.Studio

  alias BanchanWeb.Components.Icon

  prop current_user, :struct, required: true
  prop studio, :struct, required: true

  @impl true
  def update(assigns, socket) do
    socket = assign(socket, assigns)
    {:ok, socket |> assign(changeset: Studio.featured_changeset(socket.assigns.studio, %{}))}
  end

  @impl true
  def handle_event("toggle", _, socket) do
    {:ok, _} =
      Studios.update_featured(socket.assigns.current_user, socket.assigns.studio, %{
        "featured" => !socket.assigns.studio.featured
      })

    {:noreply,
     socket
     |> assign(studio: %{socket.assigns.studio | featured: !socket.assigns.studio.featured})}
  end

  def render(assigns) do
    ~F"""
    <button type="button" :on-click="toggle">
      {#if @studio.featured}
        <Icon name="star-off" size="4" /> Unfeature
      {#else}
        <Icon name="star" size="4" /> Feature
      {/if}
    </button>
    """
  end
end
