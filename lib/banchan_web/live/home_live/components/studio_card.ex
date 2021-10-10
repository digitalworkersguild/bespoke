defmodule BanchanWeb.Components.StudioCard do
  @moduledoc """
  Card for displaying studio information
  """
  use BanchanWeb, :component

  alias Surface.Components.LiveRedirect

  alias BanchanWeb.Endpoint

  prop studio, :any

  def render(assigns) do
    ~F"""
    <LiveRedirect to={Routes.studio_show_path(Endpoint, :show, @studio.handle)}>
      <div class="card">
        <div class="card-image">
          <figure class="image object-scale-down max-w-md">
            <img src={Routes.static_path(Endpoint, "/images/shop_card_default.png")}>
          </figure>
        </div>
        <div class="card-content m-3">
          <div class="media">
            <div class="float-left">
              <figure class="image">
                <img
                  src={Routes.static_path(Endpoint, "/images/denizen_default_icon.png")}
                  class="inline-block object-scale-down h-12 p-1"
                />
              </figure>
            </div>
            <div class="media-content">
              <p class="title text-xl font-medium md:leading-loose">{@studio.name}</p>
            </div>
          </div>
          <br>
          <div class="content">
            {@studio.description}
          </div>
        </div>
      </div>
    </LiveRedirect>
    """
  end
end
