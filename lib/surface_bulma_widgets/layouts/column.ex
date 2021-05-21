defmodule SurfaceBulmaWidgets.Layout.Column do
  use Surface.Component
  use SurfaceBulmaWidgets

  @doc "Css classes to propagate down to button. Default class if no class supplied is simply _button_"
  prop classes, :css_class, default: []

  @doc "The aria label for the button"
  prop aria_label, :string

  @doc "width"
  prop width, :integer, default: 0

  @doc "offset"
  prop offset, :integer, default: 0

  @doc "narrow"
  prop narrow, :boolean

  @doc """
  The content of the generated `<button>` element. If no content is provided,
  the value of property `label` is used instead.
  """
  slot default


  def render(assigns) do
    ~H"""
    <div
        aria-label={{@aria_label}}
        class={{
          ["column",
          "is-#{@width}": @width > 0,
          "is-offset-#{@offset}": @offset > 0,
          "is-narrow": @narrow,
        ] ++ @classes }}>
      <slot>
      </slot>
    </div>
    """
  end

end
