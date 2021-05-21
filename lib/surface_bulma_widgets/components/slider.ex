defmodule SurfaceBulmaWidgets.Components.Sliders do
  use Surface.Component
  use SurfaceBulmaWidgets

  @doc "If modal should be shown or not, defaults to false"
  prop aria_label, :string

  prop step, :integer, default: 10
  prop min, :integer, default: 0
  prop max, :integer, default: 100

  prop classes, :any, default: []

  prop value, :any

  def render(assigns) do
    ~H"""
      <input
        class={{ ["slider"] ++ @classes }}
        aria-label={{@aria_label}}
        step="1"
        min={{@min}}
        max={{@max}}
        value={{@value}}
        type="range"
      >
    """
  end
end
