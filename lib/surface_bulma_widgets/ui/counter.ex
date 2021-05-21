defmodule SurfaceBulmaWidgets.UI.Counter do
  use Surface.LiveComponent
  alias SurfaceBulma.Button
  use SurfaceWidgets.Bindings
  require Logger

  # prop key, :atom, required: true
  prop count, :tuple, default: {nil, 0}
  prop channel, :string, default: nil

  # data count, :integer, default: 0

  def render(assigns) do
    ~H"""
    <div class="buttons has-addons is-centered">
      <Button rounded>{{ value(@count) }}</Button>
      <Button rounded>{{ key(@count) }}</Button>
      <Button click="incr" rounded>+</Button>
      <Button click="decr" rounded>-</Button>
    </div>
    """
  end

  def handle_event("test", _, socket) do
    Logger.warn("clicked 'test' (#{inspect(socket.assigns.id)})")
    {:noreply, socket}
  end

  def handle_event("incr", _, socket) do
    Logger.warn("clicked 'incr' (#{inspect(socket.assigns.id)})")
    socket |> binding_update(:count, &(&1 + 1))
    {:noreply, socket}
  end

  def handle_event("decr", _, socket) do
    Logger.warn("clicked 'decr'")
    socket |> binding_update(:count, &(&1 -1))

    {:noreply, socket}
  end
end
