defmodule SurfaceBulmaWidgets.Components.ModalFieldEditor do
  use Surface.LiveComponent
  use SurfaceBulmaWidgets
  alias SurfaceBulma.Button
  alias SurfaceBulmaWidgets.Components.Modal
  alias SurfaceBulmaWidgets.Components.Card

  require Logger

  @moduledoc """
  The card **modal**, with various configuration options.
  The modal is a stateless component and as such requires outside
  handling of whether or not the modal should be shown.
  This component is currently not usable with javascript control of
  if component should be shown or not.
  """

  @doc "If modal should be shown or not, defaults to false"
  prop show, :boolean, default: false

  @doc "If modal should show close button at top right of darkened background"
  prop show_close_button, :boolean, default: true

  @doc "The event the modal emits if you click the close button, silently ignored if show close button is not set"
  prop close_button_event, :event

  prop var, :tuple, default: {nil, 0}

  @doc "Header content, use via Modal.Header"
  # slot(default, required: true)

  def number_pad(assigns) do
    ~F"""
      <form :on-change="select" :on-submit="submitted">
        <div class="field has-addons">
            <div class="control">
              <a class="button is-info is-large">
                Search
              </a>
            </div>
            <div class="control is-flex-grow-3">
                <input class="input is-large" type="number" id="tentacles" name="tentacles" min="10" max="100">
            </div>
        </div>
      </form>
    """

  end
  def render(assigns) do
    ~F"""
      <div>
        <Modal classes={["is-justify-content-flex-start"]} show={ value(@var) } >
          <Card classes={["pt-0"]}>
                { number_pad(assigns) }

            <Card.Footer>
                <a href="#" class="card-footer-item">Save</a>
                <a href="#" class="card-footer-item">Reset</a>
                <a href="#" class="card-footer-item">Cancel</a>
            </Card.Footer>
          </Card>
        </Modal>

        <Button
          click="editor-click"
          aria_label="open">
          Edit
        </Button>
      </div>
    """
  end

  def handle_event("editor-click", data, socket) do
    Logger.warn("number-editor selected: #{inspect data }")
    # v! = value_parser(socket, data)
    case data["value"] do
      "close" ->
        socket |> binding_update(:var, fn _v -> false end)
      _other ->
        socket |> binding_update(:var, fn v -> not v end)
    end
    {:noreply, socket}
  end

  def handle_event("editor-set", data, socket) do
    Logger.warn("number-editor set: #{inspect data }")
    socket |> binding_update(:var, fn _v -> false end)
    {:noreply, socket}
  end

  def handle_event(evt, data, socket) do
    Logger.warn("select selected: #{inspect evt} => #{inspect data}")
    {:noreply, socket}
  end

end
