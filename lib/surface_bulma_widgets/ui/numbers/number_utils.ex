defmodule SurfaceBulmaWidgets.UI.NumberUtils do

  require Logger

  def format(nil, _digits) do
    "-"
  end

  def format(value, "-") do
    value |> to_string()
  end

  @doc """
  Format should be string of "x.y" format
  where x is the characteristic
  and y is the mantissa
  """
  def format(value, fmt) when is_binary(fmt) do
    lfmt =
      fmt
      |> String.split(".")
      |> Enum.map(fn "" -> "0"; x -> x end)
      |> Enum.map(fn nstr -> {num, _rest} = Integer.parse(nstr); num end)
      |> Kernel.++([0])
      |> Enum.slice(0..1)

    Logger.info("FMT: str: #{inspect lfmt}")
    format(value, lfmt)
  end

  def format(value, fmt) when is_list(fmt) do
    fformat(value, fmt)
  end

  def format(value, digits) when is_integer(digits) and is_integer(value) do
    Logger.info("FMT: digits: #{inspect digits}")
    fformat(value, [digits, 0])
  end

  def format(value, digits) when is_integer(digits) and is_float(value) do
    Logger.info("FMT: digits: #{inspect digits}")
    fformat(value, [0, digits])
  end

  defp fformat(value, [characteristic, 0]) do
    Logger.info("FMT: fdigits: #{inspect [characteristic, 0]}")
    :io_lib.format("~#{characteristic}.. B", [value |> round])
  end

  defp fformat(value, [0, mantissa]) do
    Logger.info("FMT: fdigits: 0. #{inspect [0, mantissa]}")
    :io_lib.format("~.#{mantissa}f",[1.0*value])
  end

  defp fformat(value, [characteristic, mantissa]) do
    Logger.info("FMT: fdigits: #{inspect [characteristic, mantissa]}")
    :io_lib.format("~#{characteristic}.#{mantissa}f",[1.0*value])
  end

  def styleWidth(nil) do
    false
  end
  def styleWidth(ems) do
    "#{ems}em"
  end
end
