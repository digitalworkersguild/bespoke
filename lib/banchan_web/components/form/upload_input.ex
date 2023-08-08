defmodule BanchanWeb.Components.Form.UploadInput do
  @moduledoc """
  File upload input component.
  """
  use BanchanWeb, :component

  alias Surface.Components.LiveFileInput

  alias BanchanWeb.Components.Form.CropUploadInput
  alias BanchanWeb.Components.Icon

  prop upload, :struct, required: true
  prop label, :string, default: "Upload attachments"
  prop cancel, :event, required: true
  prop crop, :boolean, default: false
  prop aspect_ratio, :number
  prop class, :css_class
  prop hide_list, :boolean

  def render(assigns) do
    ~F"""
    <ul class={@class}>
      {#for entry <- @upload.entries}
        <li>
          {#if @hide_list}
            {#for err <- upload_errors(@upload, entry)}
              <p class="text-error">{entry.client_name}: {error_to_string(err)}</p>
            {/for}
          {#else}
            <button type="button" class="text-2xl" :on-click={@cancel} phx-value-ref={entry.ref}>&times;</button>
            {entry.client_name}
            <progress class="progress progress-primary" value={entry.progress} max="100">{entry.progress}%</progress>
            {#for err <- upload_errors(@upload, entry)}
              <p class="text-error">{error_to_string(err)}</p>
            {/for}
          {/if}
        </li>
      {/for}
    </ul>
    {#for err <- upload_errors(@upload)}
      <p class="text-error">{error_to_string(err)}</p>
    {/for}
    <div
      class="relative flex items-center justify-center border-2 border-dashed rounded-lg cursor-pointer h-15 border-primary"
      phx-drop-target={@upload.ref}
    >
      <div class="absolute cursor-pointer">
        <span class="block font-normal cursor-pointer">{@label} <Icon name="file-up" size="4" label="upload file" /></span>
      </div>
      {#if @crop}
        <CropUploadInput
          id={"#{System.unique_integer()}-cropper"}
          aspect_ratio={@aspect_ratio}
          upload={@upload}
          target={@cancel.target}
          title={"Crop " <> @label}
          class="w-full h-full opacity-0 cursor-pointer"
        />
      {#else}
        <LiveFileInput class="w-full h-full opacity-0 cursor-pointer" upload={@upload} />
      {/if}
    </div>
    """
  end

  def error_to_string(:too_large), do: "Too large"
  def error_to_string(:too_many_files), do: "You have selected too many files"
  def error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
end
