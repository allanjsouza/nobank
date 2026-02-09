# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :nobank,
  ecto_repos: [Nobank.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configure the endpoint
config :nobank, NobankWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: NobankWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Nobank.PubSub,
  live_view: [signing_salt: "cpY7Rm1f"]

# Configure Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
