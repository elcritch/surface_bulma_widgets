defmodule SurfaceBulmaWidgets.UI.Flexer do
  use Surface.LiveComponent
  use SurfaceBulmaWidgets
  import SurfaceBulmaWidgets.UIUtils

  require Logger

  prop classes, :list, default: []

  prop direction, :string, values: ["row", "row-reverse", "column", "column-reverse"]
  prop justify, :string, values: ["flex-start", "flex-end", "center", "space-around", "space-evenly", "start", "end", "left", "right"]
  prop align, :string, values: ["flex-start", "flex-end", "center", "space-between", "space-around", "space-evenly", "stretch", "start", "end", "left", "right", "baseline"]
  prop align_items, :string, values: ["stretch", "flex-start", "flex-end", "center", "start", "end", "self-start", "self-end"]
  prop wrap, :string, default: "wrap", values: ["nowrap", "wrap", "wrap-reverse"]

  prop width, :integer, default: nil

  slot default, required: true

  def render(assigns) do
    ~F"""
    <div class="is-flex
                {flexdir(@direction)}
                {jcontent(@justify)}
                {acontent(@align)}
                {aicontent(@align_items)}
                {wrcontent(@wrap)}
                {joins(@classes)}" style={rem(@width)} >
      <slot/>
    </div>
    """
  end

  defp wrcontent(nil), do: ""
  defp wrcontent(val), do: "is-flex-wrap-#{val}"

  defp aicontent(nil), do: ""
  defp aicontent(val), do: "is-align-items-#{val}"

  defp acontent(nil), do: ""
  defp acontent(val), do: "is-align-content-#{val}"

  defp jcontent(nil), do: ""
  defp jcontent(val), do: "is-justify-content-#{val}"

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
