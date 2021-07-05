defmodule SurfaceBulmaWidgets.UI.NumberButton do
  use Surface.LiveComponent
  use SurfaceBulmaWidgets
  import SurfaceBulmaWidgets.UI.NumberUtils

  require Logger

  prop name, :any, default: nil

  prop value, :number, default: 0.0

  prop digits, :string, default: "4.1"

  prop color, :any, default: "primary"
  prop rcolor, :any, default: "primary"

  @doc "Css classes to propagate down to button. Default class if no class supplied is simply _button_"
  prop class, :css_class, default: []

  prop label_class, :css_class, default: []

  prop value_class, :css_class, default: []

  prop rounded, :any, values: [true, false, "left", "right"]

  prop width, :integer, default: 6

  def render(assigns) do
    ~H"""
    <div class={{[buttons: true,
                  "has-addons": true,
                  "is-flex-wrap-nowrap": true,
                  "is-marginless": true] ++ @class}} >
      <button class={{["number-display-lbtn": true,
                        button: @class == [],
                        "is-#{@color}": @color,
                        "is-fullwidth": true,
                        "is-rounded": @rounded in [true, "left"],
                        ] ++ @label_class }}
              style="pointer-events: none;"
              color={{@color}}
              rounded={{@rounded}} >
        {{ @name || @id }}
      </button>
      <button class={{ ["number-display-rbtn": true,
                        button: @class == [],
                        "is-fullwidth": true,
                        "is-rounded": @rounded in [true, "right"],
                        ] ++ @value_class }}
              style={{[ ]}} >
        <samp>
          {{value(@value) |> format(@digits)}}
        </samp>
      </button>
    </div>
    """
  end

end
