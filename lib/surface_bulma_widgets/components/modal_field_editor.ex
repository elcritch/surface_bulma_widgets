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
  prop active, :boolean, default: false

  prop value, :number, default: nil

  prop var, :tuple, default: {nil, 0}

  prop min, :number, default: 0
  prop max, :number, default: 100

  @doc "Header content, use via Modal.Header"
  # slot(default, required: true)

  def number_pad(assigns) do
    ~F"""
      <form :on-change="select" :on-submit="submitted">
        <div class="field has-addons">
            <div class="control">
              <a class="button is-info is-large">
                { @var |> key() }
              </a>
            </div>
            <div class="control is-flex-grow-3">
                <input class="input is-large" type="number" id="value" name="value" value={@value || value(@var)} min={@min} max={@max}>
            </div>
        </div>
      </form>
    """

  end
  def render(assigns) do
    ~F"""
      <div>
        <Modal classes={["is-justify-content-flex-start"]} show={@active} >
          <Card classes={["pt-0"]}>

            {assigns |> number_pad()}

            <Card.Footer>
                <a class="card-footer-item" :on-click="editor-save"> Save </a>
                <a class="card-footer-item" :on-click="editor-reset"> Reset </a>
                <a class="card-footer-item" :on-click="editor-cancel"> Cancel </a>
            </Card.Footer>
          </Card>
        </Modal>

        <Button click="editor-open" aria_label="open">
          Edit
        </Button>
      </div>
    """
  end

  def handle_event("editor-click", data, socket) do
    Logger.warn("number-editor selected: #{inspect data }")
    case data["value"] do
      "close" ->
        socket |> binding_update(:var, fn _v -> false end)
      _other ->
        socket |> binding_update(:var, fn v -> not v end)
    end
    {:noreply, socket}
  end

  def handle_event("editor-save", data, socket) do
    Logger.warn("number-editor save: #{inspect data} from: #{inspect socket.assigns.value }")
    socket |> binding_update(:var, fn _v -> socket.assigns.value end)
    {:noreply, socket}
  end

  def handle_event("editor-reset", data, socket) do
    Logger.warn("number-editor reset")
    # val = number_parser(:float, data["value"])
    {:noreply, socket |> update(:value, fn _ -> socket.assigns.var |> value() end)}
  end

  def handle_event("editor-cancel", data, socket) do
    Logger.warn("number-editor cancel")
    {:noreply, socket |> update(:active, fn _ -> false end)}
  end

  def handle_event("editor-open", data, socket) do
    Logger.warn("number-editor open")
    {:noreply, socket |> update(:active, fn _ -> true end)}
  end

  def handle_event("select", data, socket) do
    val = number_parser(:float, data["value"])
    Logger.warn("number-editor edited: value: #{inspect val} from #{inspect data}")
    {:noreply, socket |> update(:value, fn _v -> val end)}
  end

  def handle_event(evt, data, socket) do
    Logger.warn("select selected: #{inspect evt} => #{inspect data}")
    {:noreply, socket}
  end

end
