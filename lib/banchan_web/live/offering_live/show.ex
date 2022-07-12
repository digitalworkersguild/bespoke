defmodule BanchanWeb.OfferingLive.Show do
  @moduledoc """
  Shows details about an offering.
  """
  use BanchanWeb, :surface_view

  import BanchanWeb.StudioLive.Helpers

  alias Banchan.Commissions.LineItem
  alias Banchan.Offerings

  alias Surface.Components.LiveRedirect

  alias BanchanWeb.CommissionLive.Components.Summary
  alias BanchanWeb.Components.{Button, Layout, Lightbox, Markdown, MasonryGallery}

  @impl true
  def handle_params(%{"offering_type" => offering_type} = params, uri, socket) do
    socket = assign_studio_defaults(params, socket, false, true)

    offering =
      Offerings.get_offering_by_type!(
        socket.assigns.studio,
        offering_type,
        socket.assigns.current_user_member?
      )

    gallery_images =
      offering.gallery_uploads
      |> Enum.map(&{:existing, &1})

    line_items =
      offering.options
      |> Enum.filter(& &1.default)
      |> Enum.map(fn option ->
        %LineItem{
          option: option,
          amount: option.price,
          name: option.name,
          description: option.description,
          sticky: option.sticky
        }
      end)

    if is_nil(offering.archived_at) || socket.assigns.current_user_member? do
      {:noreply,
       socket
       |> assign(
         uri: uri,
         offering: offering,
         gallery_images: gallery_images,
         line_items: line_items
       )}
    else
      {:noreply,
       socket
       |> put_flash(:error, "This offering is unavailable.")
       |> push_redirect(to: Routes.offering_index_path(Endpoint, :index))}
    end
  end

  @impl true
  def render(assigns) do
    ~F"""
    <Layout uri={@uri} current_user={@current_user} flashes={@flash}>
      <h1 class="text-3xl">{@offering.name}</h1>
      <div class="divider" />
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div class="flex flex-col md:order-2">
          <Lightbox id="card-lightbox-mobile" class="md:hidden w-full h-full bg-base-300 rounded-lg aspect-video mb-4">
            <Lightbox.Item>
              <img
                class="w-full h-full object-contain aspect-video"
                src={if @offering.card_img_id do
                  Routes.public_image_path(Endpoint, :image, @offering.card_img_id)
                else
                  Routes.static_path(Endpoint, "/images/640x360.png")
                end}
              />
            </Lightbox.Item>
          </Lightbox>
          <Summary line_items={@line_items} hide_header offering={@offering} studio={@studio} />
          {#if !Enum.empty?(@offering.tags)}
            <h3 class="pt-2 text-lg">Tags</h3>
            <ul class="flex flex-row flex-wrap gap-1">
              {#for tag <- @offering.tags}
                <li class="badge badge-sm badge-primary p-2 cursor-default overflow-hidden">{tag}</li>
              {/for}
            </ul>
            <div class="divider" />
          {/if}
          <div class="flex flex-row justify-end gap-2">
            {#if @current_user_member?}
              <LiveRedirect
                to={Routes.studio_offerings_edit_path(Endpoint, :edit, @offering.studio.handle, @offering.type)}
                class="btn text-center btn-link"
              >Edit</LiveRedirect>
            {/if}
            {#if @offering.open}
              <LiveRedirect
                to={Routes.offering_request_path(Endpoint, :new, @offering.studio.handle, @offering.type)}
                class="btn text-center btn-primary grow"
              >Request</LiveRedirect>
            {#elseif !@offering.user_subscribed?}
              <Button class="btn-info" click="notify_me">Notify Me</Button>
            {/if}
            {#if @offering.user_subscribed?}
              <Button class="btn-info" click="unnotify_me">Unsubscribe</Button>
            {/if}
          </div>
        </div>
        <div class="divider md:hidden" />
        <div class="flex flex-col md:col-span-2 md:order-1 gap-4">
          <Lightbox id="card-lightbox-md" class="hidden md:block w-full h-full bg-base-300 rounded-lg aspect-video">
            <Lightbox.Item>
              <img
                class="w-full h-full object-contain aspect-video"
                src={if @offering.card_img_id do
                  Routes.public_image_path(Endpoint, :image, @offering.card_img_id)
                else
                  Routes.static_path(Endpoint, "/images/640x360.png")
                end}
              />
            </Lightbox.Item>
          </Lightbox>
          <div class="text-2xl">Description</div>
          <Markdown class="pb-4" content={@offering.description} />
          {#if !Enum.empty?(@gallery_images)}
            <div class="text-2xl">Gallery</div>
            <MasonryGallery id="masonry-gallery" images={@gallery_images} />
          {/if}
        </div>
      </div>
    </Layout>
    """
  end
end