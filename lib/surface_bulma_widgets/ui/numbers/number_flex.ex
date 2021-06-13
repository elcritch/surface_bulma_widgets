defmodule SurfaceBulmaWidgets.UI.NumberFlex do
  use Surface.LiveComponent

  use SurfaceBulmaWidgets

  require Logger

  prop name, :any, default: nil

  prop value, :tuple, default: {nil, 0}

  prop digits, :integer, default: 3

  prop classes, :list, default: []

  def render(assigns) do
    ~H"""
      <article class="message px-1 my-1 is-small {{@classes}}" >
        <div class="message-header my-1 py-1 " >
          {{ @name || @id }}
        </div>
        <div class="message-body m-1 p-1 " >
          {{value(@value) |> format(@digits)}}
        </div>
      </article>
    """
  end

  def format(nil, _digits) do
    "-"
  end
  def format(value, digits) when is_integer(value) do
    format(1.0*value, digits)
  end
  def format(value, digits) when is_float(value) do
    :io_lib.format("~.#{digits}f",[value])
  end

end
