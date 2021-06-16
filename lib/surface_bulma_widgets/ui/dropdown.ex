defmodule SurfaceBulmaWidgets.UI.Dropdown do
  use Surface.LiveComponent
  use SurfaceBulmaWidgets
  import SurfaceBulmaWidgets.UI.NumberUtils

  require Logger

  @doc "If modal should be shown or not, defaults to false"
  prop aria_label, :string
  prop classes, :any, default: []

  # prop text, :string
  prop items, :list, default: []
  prop var, :tuple, default: {nil, 0}


  def render(assigns) do
    ~H"""
      <div class="dropdown is-hoverable">
        <div class="dropdown-trigger">
          <button class="button" aria-haspopup="true" aria-controls="dropdown-menu">
            <span>{{value(@var)}}</span>
            <span class="icon is-small">
              <i class="fas fas-angle-down" aria-hidden="true"></i>
            </span>
          </button>
        </div>
        <div class="dropdown-menu" id="dropdown-menu" role="menu">
          <div class="dropdown-content">
            <a href="#" :for={{ item <- @items }}
               :on-click="select"
               phx-value-name5="{{item}}"
               class={{"dropdown-item", "is-active": item == value(@var) }}>
              {{item}}
            </a>
          </div>
        </div>
      </div>
    """
  end

  def handle_event(evt, data, socket) do
    Logger.warn("dropwdown changed: #{inspect {evt, data} }")
    {:noreply, socket}
  end

end
