defmodule Test.MixProject do
  use Mix.Project

  @app :test
  @version "0.1.0"

  Mix.target(:target)

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.11",
      archives: [nerves_bootstrap: "~> 1.10"],
      start_permanent: Mix.env() == :prod,
      build_embedded: true,
      deps: deps(),
      releases: [{@app, release()}],
      preferred_cli_target: [run: :host, test: :host]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Test.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nerves, "~> 1.7", runtime: false},
      {:nerves_pack, "~> 0.7.0"},
      {:nerves_runtime, "~> 0.11.6"},
      # {:nerves_system_rpi3a, "~> 1.19.0", runtime: false},
      {:nerves_system_rpi3a, path: "../", runtime: false},
      {:ring_logger, "~> 0.8.3"},
      {:shoehorn, "~> 0.9"},
      {:toolshed, "~> 0.2"},
      {:vintage_net_wireguard, "~> 0.1"}
    ]
  end

  def release do
    [
      overwrite: true,
      # Erlang distribution is not started automatically.
      # See https://hexdocs.pm/nerves_pack/readme.html#erlang-distribution
      cookie: "#{@app}_cookie",
      include_erts: &Nerves.Release.erts/0,
      steps: [&Nerves.Release.init/1, :assemble],
      strip_beams: Mix.env() == :prod or [keep: ["Docs"]]
    ]
  end
end
