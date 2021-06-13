defmodule SurfaceBulmaWidgets.UIUtils do

  def joins(vals) when is_list(vals), do: Enum.join(vals, " ")
  def joins(val), do: val

end
