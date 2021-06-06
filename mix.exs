defmodule ArgxExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :argx_example,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application, do: [extra_applications: [:logger], mod: {ArgxExample.Application, []}]
  defp deps, do: [{:argx, "~> 1.1.2"}]
  defp aliases, do: [test: ["format", "test"]]
end
