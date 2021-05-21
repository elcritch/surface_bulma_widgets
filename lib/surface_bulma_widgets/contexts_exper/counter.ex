defmodule SurfaceBulmaWidgets.Exper.UiContext.Counter do
  use Surface.LiveComponent
  alias SurfaceBulma.Button
  require Logger

  prop count, :integer, default: nil

  def render(assigns) do
    ~H"""
    <Context get={{ data: data }}>
      {{ counter = @count || data[@id] }}
      <div class="buttons has-addons is-centered">
        <Button rounded>{{ counter }}</Button>
        <Button rounded>{{ @id }}</Button>
        <Button click="incr" rounded>+</Button>
        <Button click="decr" rounded>-</Button>
      </div>
      <pre>data: {{inspect data}}</pre>
    </Context>

    """
  end

  def handle_event("test", _, socket) do
    Logger.warn("clicked 'test' (#{inspect(socket.assigns.id)})")
    {:noreply, socket}
  end

  def handle_event("incr", _, socket) do
    Logger.warn("clicked 'incr' (#{inspect(socket.assigns.id)})")
    id = socket.assigns.id
    count = socket.assigns.__context__.data[id] + 1
    send(self(), {:updated, id, count})
    # {:noreply, assign(socket, count: count)}
    {:noreply, socket}
  end

  def handle_event("decr", _, socket) do
    Logger.warn("clicked 'decr'")
    id = socket.assigns.id
    count = socket.assigns.__context__.data[id] - 1
    send(self(), {:updated, id, count})
    {:noreply, socket}
  end
end

# Using the component
defmodule BtcClusterKioskWeb.ExampleLive do
  use Surface.LiveView
  alias BtcClusterKioskWeb.Surface.Hello

  def render(assigns) do
    ~H"""
    See:<br>
    <Hello id="hello1"/>
    """
  end
end
