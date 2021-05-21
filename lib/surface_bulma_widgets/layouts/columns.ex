defmodule SurfaceBulmaWidgets.Layout.Columns do
  use Surface.Component
  use SurfaceBulmaWidgets

  @doc "columns"
  slot default

  def render(assigns) do
    ~H"""
    <div class="columns">
      <slot/>
    </div>
    """
  end

end
