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

  @moduledoc """
  The card **modal**, with various configuration options.
  The modal is a stateless component and as such requires outside
  handling of whether or not the modal should be shown.
  This component is currently not usable with javascript control of
  if component should be shown or not.
  """

  @doc "Header content, use via Modal.Header"
  slot header

  @doc "Footer content, use via Modal.Footer"
  slot footer

  @doc "Image"
  slot image

  @doc "content"
  slot default, required: true


  def render(assigns) do
    ~H"""
    <div class="card">


      <div class="card-content">
        <slot/>
      </div>

      <footer :if={{slot_assigned?(:footer)}} class="card-footer">
          <slot name="footer" />
      </footer>

    </div>
    """
  end
end
