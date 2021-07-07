defmodule SurfaceBulmaWidgets.UI.Select do
  use Surface.LiveComponent
  use SurfaceBulmaWidgets

  require Logger

  prop classes, :any, default: []

  prop items, :list, default: []

  prop var, :tuple, default: {nil, 0}
  prop channel, :string, default: nil


  def render(assigns) do
    ~H"""
      <div class="field">
        <form :on-change="select">
          <label class="label">
            Testing
          </label>
          <div class="control">
            <div class="select">
              <select name="doselect">
                <option :for={{item <- @items}}>
                  {{item}}
                </option>
              </select>
            </div>
          </div>
        </form>
      </div>
    """
  end

  def handle_event("select", data, socket) do
    Logger.warn("dropwdown selected: #{inspect data }")
    # v! = value_parser(socket, data)

    # socket |> binding_update(:var, fn _v -> v! end)
    {:noreply, socket}
  end
  def handle_event(evt, data, socket) do
    Logger.warn("select selected: #{inspect evt} => #{inspect data}")
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
