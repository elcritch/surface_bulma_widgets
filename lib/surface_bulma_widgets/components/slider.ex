defmodule SurfaceBulmaWidgets.Components.Slider do
  use Surface.LiveComponent
  use SurfaceBulmaWidgets

  require Logger

  @doc "If modal should be shown or not, defaults to false"
  prop aria_label, :string

  prop step, :integer, default: 10
  prop min, :integer, default: 0
  prop max, :integer, default: 100

  prop classes, :any, default: []

  prop value, :integer, default: 20

  def render(assigns) do
    ~H"""
      <input
        class={{ ["slider"] ++ @classes }}
        aria-label={{@aria_label}}
        step={{@step}}
        min={{@min}}
        max={{@max}}
        value={{@value}}
        type="range"
      >
    """
  end

  def handle_event(evt, data, socket) do
    Logger.warn("slider changed: #{inspect {evt, data} }")
    {:noreply, socket}
  end

end
