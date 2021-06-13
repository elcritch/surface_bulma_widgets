defmodule SurfaceBulmaWidgets.UI.NumberUtils do

  def format(nil, _digits) do
    "-"
  end
  def format(value, digits) when is_integer(value) do
    format(1.0*value, digits)
  end
  def format(value, digits) when is_float(value) do
    :io_lib.format("~.#{digits}f",[value])
  end

end
