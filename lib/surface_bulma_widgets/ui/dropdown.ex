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
  prop hoverable, :boolean, default: false
  prop active, :boolean, default: false

  prop var, :tuple, default: {nil, 0}
  prop channel, :string, default: nil


  def render(assigns) do
    ~H"""
      <div class="dropdown {{cond do @hoverable -> "is-hoverable"; @active -> "is-active"; true -> "" end}}">
        <div class="dropdown-trigger">
          <button class="button" aria-haspopup="true" aria-controls="dropdown-menu">
            <div :if={{@prefix != nil}}>
              <span :if={{@prefix != nil}}>{{@prefix}}</span>
              <span>&nbsp;</span>
            </div>
            <span>{{value(@var)}}</span>
            <span class="icon is-small">
              <i class="fas fas-angle-down" aria-hidden="true">↓</i>
            </span>
          </button>
        </div>
        <div class="dropdown-menu" id="dropdown-menu" role="menu">
          <div class="dropdown-content">
            <a href="#" :for={{ item <- @items }}
               :on-click="select"
               phx-value-value="{{item}}"
               class={{"dropdown-item", "is-active": item == value(@var) }}>
              {{item}}
            </a>
          </div>
        </div>
      </div>

    """
  end

  def handle_event("select", data, socket) do
    Logger.warn("dropwdown selected: #{inspect data }")
    v! = value_parser(socket, data)

    socket |> binding_update(:var, fn _v -> v! end)
    {:noreply, socket}
  end

  def value_parser(%{assigns: assigns}, %{"value" => data}, default \\ nil) do
    Logger.warn("dropwdown selected: parsed: floats: #{inspect assigns[:floats]}")
    Logger.warn("dropwdown selected: parsed: integers: #{inspect assigns[:integers]}")
    cond do
      assigns[:floats] ->
        case data |> Float.parse() do
          {number, _rest} -> number
          :error -> default or :error
        end
      assigns[:integers] ->
        case data |> Integer.parse() do
          {number, _rest} -> number
          :error -> default or :error
        end
      true -> data
    end
  end
end
