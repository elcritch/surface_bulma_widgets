defmodule SurfaceBulmaWidgets.Components.NumberEditor do
  use Surface.Component
  use SurfaceBulmaWidgets
  alias SurfaceBulma.Button
  alias SurfaceBulmaWidgets.Components.Card

  @moduledoc """
  The card **modal**, with various configuration options.
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

  @doc "Header content, use via Modal.Header"
  slot(default, required: true)

  def render(assigns) do
    ~H"""
    <div class={{"modal", "is-active": @show}}>
      <div class="modal-background">
      </div>

      <div class="modal-content">
        <Card icon="fa-code" title="UI Components">
          <p>
            A set of common components that can be used in
            your projects, including buttons, dialogs, table grids
            and more. You can also use them as templates to
            create your own custom components.
          </p>

          <Button type={{nil}}
              :if={{@show_close_button}}
              click={{@close_button_event}}
              class="modal-close is-large"
              aria_label="close">
          </Button>
        </Card>
      </div>

    </div>
    """
  end
end
