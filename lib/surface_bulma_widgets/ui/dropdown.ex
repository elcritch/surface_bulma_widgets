defmodule SurfaceBulmaWidgets.UI.Dropdown do
  use Surface.LiveComponent
  use SurfaceBulmaWidgets

  require Logger

  @doc "If modal should be shown or not, defaults to false"
  prop aria_label, :string
  prop classes, :any, default: []

  prop prefix, :string
  prop items, :list, default: []
  # prop kind, :atom, values: [:string, :integer, :float]
  prop integers, :boolean, default: false
  prop floats, :boolean, default: false
  prop active, :boolean, default: false

  prop var, :tuple, default: {nil, 0}
  prop channel, :string, default: nil


  def render(assigns) do
    ~F"""
      <div class={["dropdown": true, "is-active": @active] ++ @classes} >
        <div class="dropdown-trigger">
          <button class="button" :on-click="open" aria-haspopup="true" aria-controls="dropdown-menu">
            <div :if={@prefix != nil}>
              <span :if={@prefix != nil}>{@prefix}</span>
              <span>&nbsp;</span>
            </div>
            <span>{value(@var)}</span>
            <span class="icon is-small">
              <i class="fas fas-angle-down" aria-hidden="true">↓</i>
            </span>
          </button>
        </div>
        <div class="dropdown-menu" id="dropdown-menu" role="menu">
          <div class="dropdown-content">
            {#for item <- @items}
              <a href="#" :on-click="select" phx-value-value={item} class={"dropdown-item", "is-active": item == value(@var) }>
                {item}
              </a>
            {/for}
          </div>
        </div>
      </div>

    """
  end

  def handle_event("open", data, socket) do
    Logger.warn("dropwdown open: #{inspect data}")
    {:noreply, socket |> update(:active, & not &1)}
  end

  def handle_event("select", data, socket) do
    Logger.warn("dropwdown selected: #{inspect data }")
    v! = value_parser(socket, data["value"])
    socket |> binding_update(:var, fn _v -> v! end)
    {:noreply, socket}
  end

end
