defmodule SurfaceBulmaWidgets.Components.Card do
  use Surface.Component
  alias SurfaceBulma.Button
  use SurfaceBulmaWidgets

  defmodule Header do
    use Surface.Component, slot: "header"
  end

  defmodule Footer do
    use Surface.Component, slot: "footer"
  end

  defmodule Content do
    use Surface.Component, slot: "content"
  end

  @moduledoc """
  The card **modal**, with various configuration options.
  The modal is a stateless component and as such requires outside
  handling of whether or not the modal should be shown.
  This component is currently not usable with javascript control of
  if component should be shown or not.
  """

  @doc "If modal should be shown or not, defaults to false"
  prop show, :boolean, default: false

  @doc "If modal should show close button at top right of card"
  prop show_close_button, :boolean, default: true

  @doc "What event to emit on close event"
  prop close_event, :event, default: "modal_close"

  @doc "Header content, use via Modal.Header"
  slot header

  @doc "Footer content, use via Modal.Footer"
  slot footer

  @doc "Image"
  slot image

  @doc "content"
  slot content

  def render(assigns) do
    ~H"""
    <div class="card">

      <header class="card-header" >
        <slot name="header" />
      </header>

      <div class="card-image">
        <slot name="image" />
      </div>

      <div class="card-content">
        <slot name="content" />
      </div>

      <footer class="card-footer">
          <slot name="footer" />
      </footer>

    </div>
    """
  end
end
