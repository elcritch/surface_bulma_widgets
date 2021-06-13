defmodule SurfaceBulmaWidgets.UI.Flexer do
  use Surface.LiveComponent

  use SurfaceBulmaWidgets

  require Logger

  prop classes, :list, default: []

  prop direction, :string, values: ["row", "row-reverse", "column", "column-reverse"]

  prop width, :integer, default: nil

  slot default, required: true

  def render(assigns) do
    ~H"""
    <div class="is-flex {{ flexdir(@direction) }}" style="{{rem(@width)}}">
      <slot/>
    </div>
    """
  end

  defp rem(nil), do: ""
  defp rem(val), do: "width: #{val}em;"

  defp flexdir(val) do
    case val do
      "row" ->
        "is-flex-direction-row"
      "row-reverse" ->
        "is-flex-direction-row-reverse"
      "column" ->
        "is-flex-direction-column"
      "column-reverse" ->
        "is-flex-direction-column-reverse"
      nil ->
        ""
    end
  end
end
