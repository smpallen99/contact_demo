# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :nested, Nested.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "m3g6ltbv+hunhzFPWAfLWNaGIxoUn7KirHwPyYl6NSP44qOQfaMAj+RgR/Fr1JJS",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Nested.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :phoenix, :template_engines,
  haml: PhoenixHaml.Engine

config :ex_admin,
  repo: Nested.Repo,
  module: Nested,
  modules: [
    Nested.ExAdmin.Dashboard,
    Nested.ExAdmin.Contact,
    Nested.ExAdmin.Group,
    Nested.ExAdmin.Category,
    Nested.ExAdmin.User,
    Nested.ExAdmin.Role
  ]

config :xain, :quote, "'"
config :xain, :after_callback, {Phoenix.HTML, :raw}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

