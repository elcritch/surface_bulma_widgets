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
      <article class="message is-small is-marginless {{@classes}}" >
        <div class="message-header is-primary py-1" >
          {{ @name || @id }}
        </div>
        <div class="message-body py-1 " >
          {{value(@value) |> format(@digits)}}
        </div>
      </article>
    """
  end

end
