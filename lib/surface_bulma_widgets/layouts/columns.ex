defmodule SurfaceBulmaWidgets.Layouts.Columns do
  use Surface.Component
  use SurfaceBulmaWidgets

  @doc "multiline"
  prop multiline, :boolean, default: false

  @doc "mobile"
  prop mobile, :boolean, default: false

  @doc "centered"
  prop centered, :boolean, default: false

  @doc "gapless"
  prop gapless, :boolean, default: false

  @doc "columns"
  slot default

  def render(assigns) do
    ~F"""
      <div class={
            "columns",
            "is-multiline": @multiline,
            "is-mobile": @mobile,
            "is-centered": @centered,
            "is-gapless": @gapless
          } >
        <slot/>
      </div>
    """
  end
end

defmodule SurfaceBulmaWidgets.Layouts.Column do
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
    ~F"""
    <div
        aria-label={@aria_label}
        class={
          ["column",
          "is-#{@width}": @width > 0,
          "is-offset-#{@offset}": @offset > 0,
          "is-narrow": @narrow,
        ] ++ @classes }>
      <slot>
      </slot>
    </div>
    """
  end

end
