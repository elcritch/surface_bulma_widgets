defmodule SurfaceBulmaWidgets.UI.RangedSlider do
  use Surface.LiveComponent
  alias SurfaceBulma.Button

  use SurfaceBulmaWidgets
  alias SurfaceBulmaWidgets.Components.Progress

  require Logger

  # prop key, :atom, required: true
  prop var, :tuple, default: {nil, 20}, required: true
  prop channel, :string, default: nil

  prop min, :integer, default: 0
  prop max, :integer, default: 100

  # data var, :integer, default: 0

  def render(assigns) do
    ~H"""
    <div class="buttons has-addons is-centered">
      <button class={{ "button", "is-rounded", "is-info" }}>
        {{ key(@var) }}
      </button>
      <button class={{ "button" }} style="width: 4em;">
        {{ value(@var) }}
      </button>

      <progress
        class="progress is-radiusless number-display-lbtn "
        min={{@min}}
        max={{@max}}
        style="width: 4em; min-height: 2.4em; margin-top: 1em;"
        value={{@var |> value()}} >
      </progress>
      <Button click="incr" rounded>+</Button>
      <Button click="decr" rounded>-</Button>
    </div>
    """
  end

  def handle_event("incr", _, socket) do
    # Logger.warn("clicked 'incr' (#{inspect(socket.assigns.id)})")
    socket |> binding_update(:var, &(&1 + 1))
    {:noreply, socket}
  end

  def handle_event("decr", _, socket) do
    # Logger.warn("clicked 'decr'")
    socket |> binding_update(:var, &(&1 -1))

    {:noreply, socket}
  end
end
