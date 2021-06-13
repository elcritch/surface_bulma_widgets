defmodule SurfaceBulmaWidgets.MixProject do
  use Mix.Project

  def project do
    [
      app: :surface_bulma_widgets,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:jason, "~> 1.0"},
      {:surface, "~> 0.4.1", override: true},
      {:surface_bulma, github: "surface-ui/surface_bulma"},
    ]
  end
end
