defmodule SurfaceBulmaWidgets.UI.RangedSlider do
  use Surface.LiveComponent
  alias SurfaceBulma.Button

  use SurfaceBulmaWidgets
  alias SurfaceBulmaWidgets.UI.Flexer
  import SurfaceBulmaWidgets.UI.NumberUtils

  require Logger

  # prop key, :atom, required: true
  prop name, :string, default: nil
  prop var, :tuple, required: true

  prop channel, :string, default: nil

  prop step, :integer, default: 1

  prop min, :integer, default: 0

  prop max, :integer, default: 100

  prop rounded, :boolean, default: true

  prop width, :integer, default: 6

  prop digits, :integer, default: 1

  # data var, :integer, default: 0

  def render(assigns) do
    ~H"""
    <div class="buttons has-addons is-centered">
      <button class={{button: true,
                      "is-rounded": @rounded,
                      "is-info": true }}>
        {{ @name || key(@var) }}
      </button>
      <button class={{button: true }} >
        {{value(@var) |> format(@digits)}}
      </button>
      <Button click="decr" rounded={{@rounded}}>-</Button>
      <progress
        class={{"progress",
                "is-radiusless",
                "is-fullwidth"}}
        max={{@max - @min}}
        style="width: {{@width}}em; min-height: 2.4em; margin-top: 1em;"
        value={{@var |> value() |> Kernel.-(@min)}} >
      </progress>
      <Button click="incr" rounded={{@rounded}}>+</Button>
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
