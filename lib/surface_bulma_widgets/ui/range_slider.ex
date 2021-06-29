defmodule SurfaceBulmaWidgets.UI.RangedSlider do
  use Surface.LiveComponent
  alias SurfaceBulma.Button

  use SurfaceBulmaWidgets

  require Logger

  # prop key, :atom, required: true
  prop var, :tuple, default: {nil, 20}, required: true
  prop channel, :string, default: nil

  prop step, :integer, default: 1
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
        max={{@max - @min}}
        style="width: 4em; min-height: 2.4em; margin-top: 1em;"
        value={{@var |> value() |> Kernel.-(@min)}} >
      </progress>
      <Button click="decr" rounded>-</Button>
      <Button click="incr" rounded>+</Button>
    </div>
    """
  end

  def handle_event("incr", data, socket) do
    %{step: step, max: top} = socket.assigns
    socket |> binding_update(:var, &(min(top, &1 + step)))
    {:noreply, socket}
  end

  def handle_event("decr", _, socket) do
    %{min: bottom, step: step} = socket.assigns
    socket |> binding_update(:var, &(max(&1 - step, bottom)))
    {:noreply, socket}
  end
end
