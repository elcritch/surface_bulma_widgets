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

  prop step, :number, default: 1

  prop min, :number, default: 0

  prop max, :number, default: 100

  prop rounded, :boolean, default: true

  prop digits, :integer, default: 1

  prop widths, :map, default: %{}

  # data var, :integer, default: 0

  def render(assigns) do
    ~H"""
    <div class="buttons has-addons is-centered">
      <button class={{button: true,
                      "is-rounded": @rounded,
                      "is-info": true }}
              style={{width: styleWidth(@widths[:label]) }} >
        {{ @name || key(@var) }}
      </button>
      <button class={{button: true }}
        style={{width: styleWidth(@widths[:number]) }}>
        {{value(@var) |> format(@digits)}}
      </button>
      <button id={{@id <> "decrBtn"}} class={{button: true}}
              :on-click="decr"
              phx-value-action="decr"
              rounded={{@rounded}}
              phx-hook="PhxRepeatClick"
          >▼</button>
      <progress
        class={{"progress",
                "is-radiusless",
                "is-fullwidth"}}
        max={{@max - @min}}
        style={{width: to_string(@widths[:progress] || 4) <> "em",  "min-height": "2.4em", "margin-top": "1em"}}
        value={{@var |> value() |> Kernel.-(@min)}} >
      </progress>
      <button class={{button: true}}
              :on-click="incr" rounded={{@rounded}}>▲</button>
    </div>
    """
  end

  def handle_event("incr", data, socket) do
    %{step: step, max: top} = socket.assigns
    socket |> binding_update(:var, &(min(top, &1 + step)))
    {:noreply, socket}
  end

  def handle_event("decr", data, socket) do
    Logger.warning("decr: #{inspect "decr"}")
    Logger.warning("decr: data: #{inspect data}")
    %{min: bottom, step: step} = socket.assigns
    socket |> binding_update(:var, &(max(&1 - step, bottom)))
    {:noreply, socket}
  end

  def handle_event("clicking", data, socket) do
    Logger.warning("otherevt: #{inspect "clicking"}")
    Logger.warning("otherevt: data: #{inspect data}")
    case data["action"] do
      "decr" ->
        %{min: bottom, step: step} = socket.assigns
        socket |> binding_update(:var, &(max(&1 - step, bottom)))
    end

    {:noreply, socket}
  end

end
