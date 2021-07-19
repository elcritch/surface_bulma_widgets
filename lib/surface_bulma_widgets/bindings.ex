defmodule SurfaceBulmaWidgets.Bindings do
  require Logger


  defmacro bind(expr) do

    name =
      case expr do
        { {:., _meta1, [Phoenix.LiveView.Engine, :fetch_assign!]}, _meta2, [{:assigns, _meta3, nil}, name] } ->
          name
        _other ->
          raise %ArgumentError{message: "only simple `@var` assigns work for now"}
      end

    quote do
      {unquote(name), unquote(expr)}
    end
  end

  def value({_k,v}) do
    v
  end

  def key({k,_v}) do
    k
  end

  def binding_send(socket, msg) do
    case socket.assigns[:channel] do
      {mod, name} ->
        Phoenix.PubSub.broadcast(mod, name, msg)
      _other ->
        send(self(), msg)
    end
  end

  def binding_update(socket, name, update_fn) do
    id = socket.assigns[name] |> key()
    value = socket.assigns[name] |> value() |> update_fn.()

    socket |> binding_send({:update_bind, id, value})
  end

  def value_parser(%{assigns: assigns}, data, default \\ nil) do
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

  def number_parser(kind, data, default \\ nil) do
    case kind do
      :float ->
        case data |> Float.parse() do
          {number, _rest} -> number
          :error -> default or :error
        end
      :integer ->
        case data |> Integer.parse() do
          {number, _rest} -> number
          :error -> default or :error
        end
    end
  end
end
