defmodule BanchanWeb.AuthLive.Components.AuthLayout do
  @moduledoc """
  Layout component for auth-related pages for consistent look & feel.
  """
  use BanchanWeb, :component

  alias BanchanWeb.Components.Layout

  prop flashes, :any, required: true

  slot default

  def render(assigns) do
    ~F"""
    <Layout flashes={@flashes} padding={0}>
      <div class="flex flex-col items-center w-full h-full">
        <div class="w-full max-w-md p-12 mx-auto my-auto rounded-xl bg-base-200">
          <#slot />
        </div>
      </div>
    </Layout>
    """
  end
end
