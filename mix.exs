defmodule ContactDemo.Mixfile do
  use Mix.Project

  def project do
    [app: :contact_demo,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {ContactDemo, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :coherence]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.1", override: true},
     {:phoenix_ecto, "~> 3.0.0"},
     {:postgrex, ">= 0.0.0"},
     # {:phoenix_ecto, "~> 2.0.0", override: true}, # the override is necessary
     {:ecto, "~> 2.0", override: true},           # the override is necessary
     {:phoenix_html, "~> 2.3"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.9"},
     {:phoenix_haml, "~> 0.2"},
     {:faker, "~> 0.6.0"},
     {:ex_admin, github: "smpallen99/ex_admin"},
     {:coherence, github: "smpallen99/coherence"},
     # {:coherence, path: "../coherence"},
     # {:coherence, "~> 0.1"},
     {:cowboy, "~> 1.0"}]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
