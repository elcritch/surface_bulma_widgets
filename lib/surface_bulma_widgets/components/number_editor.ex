defmodule SurfaceBulmaWidgets.Components.NumberEditor do
  use Surface.LiveComponent
  use SurfaceBulmaWidgets
  alias SurfaceBulma.Button
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
  prop(show, :boolean, default: false)

  @doc "If modal should show close button at top right of darkened background"
  prop(show_close_button, :boolean, default: true)

  @doc "The event the modal emits if you click the close button, silently ignored if show close button is not set"
  prop(close_button_event, :event)

  prop var, :tuple, default: {nil, 0}

  @doc "Header content, use via Modal.Header"
  # slot(default, required: true)

  def number_pad(assigns) do
    ~H"""
                    <div class="box m-0">
                      <div class="buttons my-0">
                        <button class="button is-medium is-family-monospace	">1</button>
                        <button class="button is-medium is-family-monospace	">2</button>
                        <button class="button is-medium is-family-monospace	">3</button>
                      </div>
                      <div class="buttons my-0">
                        <button class="button is-medium is-family-monospace	">4</button>
                        <button class="button is-medium is-family-monospace	">5</button>
                        <button class="button is-medium is-family-monospace	">6</button>
                      </div>
                      <div class="buttons my-0">
                        <button class="button is-medium is-family-monospace	">7</button>
                        <button class="button is-medium is-family-monospace	">8</button>
                        <button class="button is-medium is-family-monospace	">9</button>
                      </div>
                      <div class="buttons my-0">
                        <button class="button is-medium is-family-monospace	">.</button>
                        <button class="button is-medium is-family-monospace	">0</button>
                        <button class="button is-medium is-family-monospace	">⌫</button>
                      </div>
                    </div>
    """

  end
  def render(assigns) do
    ~H"""
    <article >
      <div class={{"modal", "is-active": value(@var)}}>
        <div class="modal-background">
        </div>

        <div class="modal-content">

          <Card icon="fa-code" title="UI Components">

              <div class="tile is-ancestor">

                <div class="columns ">
                  <div class="column is-4">
                    Number
                  </div>
                  <div class="column is-4">
                  </div>
                </div>

                <Button type={{nil}}
                    :if={{@show_close_button}}
                    click="editor-click"
                    value="close"
                    class="modal-close is-large"
                    aria_label="close">
                </Button>
              </div>

            <Card.Footer>
              <Button color="primary"
                click="editor-set"
                aria_label="close">
                Accept
              </Button>
              <Button color="danger"
                value="close"
                click="editor-click"
                aria_label="close">
                Close
              </Button>

            </Card.Footer>
          </Card>
        </div>

      </div>
      <Button
        click="editor-click"
        aria_label="open">
        Edit
      </Button>
    </article>
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
end
