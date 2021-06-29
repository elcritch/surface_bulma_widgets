defmodule SurfaceBulmaWidgets.UI.NumberUtils do

  def format(nil, _digits) do
    "-"
  end
  def format(value, [pre, 0]) do
    :io_lib.format("~#{pre}.. B", [value])
  end
  def format(value, digits) when is_integer(value) do
    format(1.0*value, digits)
  end
  def format(value, digits) when is_float(value) do
    :io_lib.format("~.#{digits}f",[value])
  end

  def styleWidth(nil) do
    false
  end
  def styleWidth(ems) do
    "#{ems}em"
  end
end
