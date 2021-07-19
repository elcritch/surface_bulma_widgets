defmodule SurfaceBulmaWidgets.UI.NumberTag do
  use Surface.LiveComponent
  use SurfaceBulmaWidgets
  import SurfaceBulmaWidgets.UI.NumberUtils

  require Logger

  prop name, :any, default: nil

  prop value, :number, default: 0.0

  prop digits, :string, default: "5.1"

  prop color, :any, default: "primary"
  prop rcolor, :any, default: "primary"

  prop label_class, :css_class, default: []
  prop value_class, :css_class, default: []

  prop rounded, :any, values: [true, false, "left", "right"]

  prop widths, :map, default: %{}

  def render(assigns) do
    ~F"""
    <div class={tags: true,
                 "has-addons": true,
                 "is-flex-wrap-nowrap": true} >
      <span class={["number-display-ltag": true,
                     tag: true,
                     "is-#{@color}": @color,
                    ] ++ @label_class }
              style="pointer-events: none;"
              color={@color}
              rounded={@rounded} >
        { @name || @id }
      </span>
      <span class={["number-display-rtag": true,
                     tag: true] ++ @value_class } >
        <samp style={width: styleWidth(@widths[:number]) } >
        {value(@value) |> format(@digits)}
        </samp>
      </span>
    </div>
    """
  end

end
