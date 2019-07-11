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
      ],
      description: description(),
      package: package(),
      # Docs
      name: "ForgeAbi",
      source_url: "https://github.com/arcblock/forge-abi",
      homepage_url: "https://github.com/arcblock/forge-abi",
      docs: [
        main: "ForgeAbi",
        extras: ["README.md"]
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
      {:ex_abci_proto, "~> 0.9"},
      {:jason, "~> 1.1"},
      {:protobuf, "~> 0.6.1"},
      {:typed_struct, "~> 0.1.4"},

      # dev and test
      {:credo, "~> 1.0.0", only: [:dev, :test]},
      {:dialyxir, "~> 1.0.0-rc.4", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.19.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: [:test]},
      {:pre_commit_hook, "~> 1.2", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    """
    Forge Abi contains forge related protocol buffer definitions and Goldorin GraphQL definitions. It is a dependency for Forge and Forge Elixir SDK. Normally as a Dapp developer you won't use the code here directly but you'd use the types defined here.
    """
  end

  defp package do
    [
      files: [
        "config",
        "lib",
        "mix.exs",
        "README*",
        "LICENSE",
        "version",
        ".elixir_version"
      ],
      licenses: ["Apache 2.0"],
      maintainers: [
        "christinaleizhou@gmail.com",
        "cnredink@gmail.com",
        "dingpl716@gmail.com",
        "sunboshan@gmail.com",
        "tyr.chen@gmail.com"
      ],
      links: %{
        "GitHub" => "https://github.com/arcblock/forge-abi",
        "Docs" => "https://hexdocs.pm/forge-abi"
      }
    ]
  end
end
