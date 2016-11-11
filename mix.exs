defmodule ContactDemo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :contact_demo,
      version: "0.0.1",
      elixir: "1.3.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases,
      deps: deps,
      preferred_cli_env: [
                          coveralls: :test,
                          "coveralls.detail": :test,
                          "coveralls.html": :test,
                          "coveralls.post": :test,
                          commit: :test,
                          itest: :test,
                          credo: :test
                        ],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ContactDemo, []},
      applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext, :phoenix_ecto, :postgrex, :coherence]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:coherence, "~> 0.2.0"},
      {:cowboy, "~> 1.0"},
      {:credo, "~> 0.5.2", only: :test, app: false},
      {:ecto, "~> 2.0", override: true},           # the override is necessary
      {:ex_admin, github: "smpallen99/ex_admin"},
      {:ex_machina, "~> 1.0.2", only: :test},
      {:excoveralls, "~> 0.5.1", only: :test, app: false},
      {:faker, "~> 0.7.0"},
      {:gettext, "~> 0.9"},
      {:phoenix, "~> 1.2", override: true},
      {:phoenix_ecto, "~> 3.0.0"},
      {:phoenix_haml, "~> 0.2"},
      {:phoenix_html, "~> 2.3"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:postgrex, ">= 0.0.0"}
    ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.seed": "run priv/repo/seeds.exs",
      "ecto.setup": ["ecto.create", "ecto.migrate", "ecto.seed"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"],
      commit: ["deps.get --only #{Mix.env}", "coveralls.html", "credo --strict"]
    ]
  end
end
