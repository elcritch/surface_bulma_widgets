defmodule SurfaceBulmaWidgets do
  @moduledoc """
  Documentation for `SurfaceBulmaWidgets`.
  """


  @doc """
  Use to import Bindings.

  """
  defmacro __using__(_opts) do
    quote do
      import SurfaceBulmaWidgets
      import SurfaceBulmaWidgets.Bindings

      def handle_info({:update_bind, name, value} = msg, socket) do
        {:noreply, socket |> assign([{name, value}]) }
      end

      defoverridable handle_info: 2

    end
  end

end
