defmodule SurfaceBulmaWidgets.UI.NumberFlex do
  use Surface.LiveComponent
  use SurfaceBulmaWidgets

  import SurfaceBulmaWidgets.UI.NumberUtils
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

end
