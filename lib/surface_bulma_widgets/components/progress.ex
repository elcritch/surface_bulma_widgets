defmodule SurfaceBulmaWidgets.Components.Progress do
  use Surface.LiveComponent
  use SurfaceBulmaWidgets

  require Logger

  @doc "If modal should be shown or not, defaults to false"
  prop aria_label, :string
  prop classes, :any, default: []

  prop min, :integer, default: 0
  prop max, :integer, default: 100

  prop value, :integer, required: true

  def render(assigns) do
    ~H"""
      <progress
        class={{ ["progress"] ++ @classes }}
        aria-label={{@aria_label}}
        min={{@min}}
        max={{@max}}
        value={{@value}} >
      </progress>
    """
  end

  def handle_event(evt, data, socket) do
    Logger.warn("slider changed: #{inspect {evt, data} }")
    {:noreply, socket}
  end

end
