defmodule SurfaceBulmaWidgets.UI.NumberButton do
  use Surface.LiveComponent
  alias SurfaceBulma.Button

  use SurfaceBulmaWidgets

  require Logger

  prop name, :any, default: nil

  prop value, :tuple, default: {nil, 0}

  prop digits, :integer, default: 3

  prop color, :any, default: "primary"
  prop rcolor, :any, default: "primary"

  @doc "Css classes to propagate down to button. Default class if no class supplied is simply _button_"
  prop class, :css_class, default: []

  prop label_class, :css_class, default: []

  prop value_class, :css_class, default: []

  prop rounded, :any, values: [true, false, "left", "right"]

  def render(assigns) do
    ~H"""
    <div class={{[buttons: true,
                  "has-addons": true,
                  "is-centered": true,
                  "is-marginless": true] ++ @class}} >
      <button class={{["number-display-lbtn": true,
                        button: @class == [],
                        "is-#{@color}": @color,
                        "is-rounded": @rounded in [true, "left"],
                        ] ++ @label_class }}
              style="pointer-events: none;"
              color={{@color}}
              rounded={{@rounded}} >
        {{ @name || @id }}
      </button>
      <button class={{ ["number-display-rbtn": true,
                        button: @class == [],
                        "is-rounded": @rounded in [true, "right"],
                        ] ++ @value_class }}
              style="pointer-events: none;"
                  >
        {{value(@value) |> format(@digits)}}
      </button>
    </div>
    """
  end

  def format(nil, _digits), do: "-"
  def format(value, digits) when is_integer(value), do: format(1.0*value, digits)
  def format(value, digits) when is_float(value), do: :io_lib.format("~.#{digits}f",[value])

end
