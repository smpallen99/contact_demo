# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :contact_demo, ContactDemo.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "m3g6ltbv+hunhzFPWAfLWNaGIxoUn7KirHwPyYl6NSP44qOQfaMAj+RgR/Fr1JJS",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: ContactDemo.PubSub,
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
  # theme: ExAdmin.Theme.ActiveAdmin,
  repo: ContactDemo.Repo,
  module: ContactDemo,
  skin_color: :purple,
  theme_selector: [
    {"AdminLte",  ExAdmin.Theme.AdminLte2},
    {"ActiveAdmin", ExAdmin.Theme.ActiveAdmin}
  ],
  modules: [
    ContactDemo.ExAdmin.Dashboard,
    ContactDemo.ExAdmin.Contact,
    ContactDemo.ExAdmin.Group,
    ContactDemo.ExAdmin.Category,
    ContactDemo.ExAdmin.User,
    ContactDemo.ExAdmin.Role
  ]

config :contact_demo, ecto_repos: [ContactDemo.Repo]

config :xain, :after_callback, {Phoenix.HTML, :raw}

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: ContactDemo.User,
  repo: ContactDemo.Repo,
  module: ContactDemo,
  logged_out_url: "/",
  password_hash_field: :encrypted_password,
  login_field: :username,
  email_from: {System.get_env("NAME"), System.get_env("EMAIL")},
  opts: [:rememberable, :invitable, :authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :confirmable, :registerable]

config :coherence, ContactDemo.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: System.get_env("API_KEY")
# %% End Coherence Configuration %%

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
