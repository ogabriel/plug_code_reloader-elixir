defmodule PlugCodeReloader.MixProject do
  use Mix.Project

  def project do
    [
      app: :plug_code_reloader,
      version: "0.1.1",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/ogabriel/plug_code_reloader-elixir",
      docs: [
        main: "plug_code_reloader",
        extras: ["README.md", "LICENSE"]
      ],
      package: [
        name: "plug_code_reloader",
        files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/ogabriel/plug_code_reloader-elixir"}
      ],
      description: "Plug to code reload",
      dialyzer: [
        plt_add_apps: [:mix],
        plt_core_path: "_build/plts/core",
        plt_local_path: "_build/plts/local"
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.cobertura": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.18"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.18", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
