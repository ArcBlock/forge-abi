defmodule ForgeAbi.MixProject do
  use Mix.Project
  @top File.cwd!()

  @version @top |> Path.join("version") |> File.read!() |> String.trim()
  @elixir_version @top |> Path.join(".elixir_version") |> File.read!() |> String.trim()

  def project do
    [
      app: :forge_abi,
      version: @version,
      elixir: @elixir_version,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [ignore_warnings: ".dialyzer_ignore.exs", plt_add_apps: []],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test,
        "coveralls.json": :test
      ]
    ]
  end

  def application do
    [
      mod: {ForgeAbi.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_abci_proto, "~> 0.8"},
      {:jason, "~> 1.1"},
      {:typed_struct, "~> 0.1.4"},

      # dev and test
      {:credo, "~> 1.0.0", only: [:dev, :test]},
      {:dialyxir, "~> 1.0.0-rc.4", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.19.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: [:test]},
      {:pre_commit_hook, "~> 1.2", only: [:dev, :test], runtime: false}
    ]
  end
end
