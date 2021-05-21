defmodule BtcClusterKioskWeb.Surface.NumberDisplay do
  use Surface.LiveComponent
  alias SurfaceBulma.Button
  use SurfaceWidgets.Bindings
  require Logger

  # prop key, :atom, required: true
  prop value, :tuple, default: {nil, 0}
  prop digits, :integer, default: 3

  # data count, :integer, default: 0

  def render(assigns) do
    ~H"""
    <div class="buttons has-addons is-centered is-marginless">
      <Button class="number-display-lbtn button" active=true color="info" rounded>{{ @id }}</Button>
      <Button class="number-display-rbtn button" active=true selected=false >{{ value(@value) |> format(@digits)  }}</Button>
    </div>
    """
  end

  @spec format(nil | number, any) :: <<_::8>> | [list | char]
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
