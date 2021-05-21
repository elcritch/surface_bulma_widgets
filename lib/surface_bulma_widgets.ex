defmodule SurfaceBulmaWidgets do
  @moduledoc """
  Documentation for `SurfaceBulmaWidgets`.
  """


  @doc """
  Use to import Bindings.

  """
  defmacro __using__(_opts) do
    quote do
      import SurfaceBulmaWidgets.Bindings
    end
  end
end
