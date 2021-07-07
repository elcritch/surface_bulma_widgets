defmodule SurfaceBulmaWidgets.Components.Modal do
  use Surface.Component
  alias SurfaceBulma.Button

  @moduledoc """
  The non-card **modal**, with various configuration options.
  The modal is a stateless component and as such requires outside
  handling of whether or not the modal should be shown.

  This component is currently not usable with javascript control of
  if component should be shown or not.
  """

  @doc "If modal should be shown or not, defaults to false"
  prop(show, :boolean, default: false)

  @doc "If modal should show close button at top right of darkened background"
  prop(show_close_button, :boolean, default: true)

  @doc "The event the modal emits if you click the close button, silently ignored if show close button is not set"
  prop(close_button_event, :event)

  prop classes, :any, default: []

  slot(default, required: true)

  def render(assigns) do
    ~H"""
    <div class={{["modal"] ++ @classes ++ ["is-active": @show] }}>
      <div class="modal-background"></div>
        <div class="modal-content">
          <slot/>
        </div>
        <Button type={{nil}} :if={{@show_close_button}} click={{@close_button_event}} class="modal-close is-large" aria_label="close"></Button>
      </div>
    """
  end
end
