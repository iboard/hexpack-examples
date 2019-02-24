defmodule HexpackExamples.MixProject do
  use Mix.Project

  def project do
    [
      app: :hexpack_examples,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger,:timewrap],
      mod: {HexpackExamples.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:data_source, "~> 0.1" },
      {:bucketier, "~> 0.1" },
      {:timewrap, "~> 0.1" }
    ]
  end
end
