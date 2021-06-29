defmodule SurfaceBulmaWidgets.UI.NumberTag do
  use Surface.LiveComponent
  use SurfaceBulmaWidgets
  import SurfaceBulmaWidgets.UI.NumberUtils

  require Logger

  prop name, :any, default: nil

  prop value, :number, default: 0.0

  prop digits, :integer, default: 3

  prop color, :any, default: "primary"
  prop rcolor, :any, default: "primary"

  prop label_class, :css_class, default: []
  prop value_class, :css_class, default: []

  prop rounded, :any, values: [true, false, "left", "right"]

  prop width, :integer, default: 6

  def render(assigns) do
    ~H"""
    <div class={{tags: true,
                 "has-addons": true,
                 "is-flex-wrap-nowrap": true}} >
      <span class={{["number-display-ltag": true,
                     tag: true,
                     "is-#{@color}": @color,
                    ] ++ @label_class }}
              style="pointer-events: none;"
              color={{@color}}
              rounded={{@rounded}} >
        {{ @name || @id }}
      </span>
      <span class={{["number-display-rtag": true,
                     tag: true] ++ @value_class }}
              style={{[ ]}} >
        {{value(@value) |> format(@digits)}}
      </span>
    </div>
    """
  end

end
