defmodule BanchanWeb.Components.Form.TextArea do
  @moduledoc """
  Banchan-specific TextArea.
  """
  use BanchanWeb, :component

  alias Surface.Components.Form.{ErrorTag, Field, Label, TextArea}
  alias Surface.Components.Form.Input.InputContext

  prop name, :any, required: true
  prop opts, :any, default: []
  prop label, :string
  prop wrapper_class, :css_class
  prop class, :css_class

  slot left
  slot right
  def render(assigns) do
    ~F"""
    <Field class="field" name={@name}>
      {#if @label}
      <Label class="label">
      </Label>
      {#else}
      <Label class="label" />
      {/if}
      <div class={"control", @wrapper_class}>
        <#slot name="left" />
        <InputContext :let={form: form, field: field}>
          <TextArea
            class={
              "textarea",
              "textarea-bordered",
              "textarea-primary",
              "h-24",
              @class,
              "is-danger": !Enum.empty?(Keyword.get_values(form.errors, field))
            }
            opts={@opts}
          />
        </InputContext>
        <#slot name="right" />
      </div>
      <ErrorTag class="help is-danger" />
    </Field>
    """
  end
end
