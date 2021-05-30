# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :safeboda_fullstack,
  ecto_repos: [SafebodaFullstack.Repo]

# Configures the endpoint
config :safeboda_fullstack, SafebodaFullstackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MLbVhKmkvsy7Ng78BCQdC/2LRrlrpbf80sAyUzvba0jNMK+QdqUCYhdIU7A/13H9",
  render_errors: [view: SafebodaFullstackWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SafebodaFullstack.PubSub,
  live_view: [signing_salt: "fXvUaZ+4"]

config :safeboda_fullstack, SafebodaFullstackWeb.AdminToken,
  issuer: "safeboda_fullstack",
  secret_key: "ub6UE2JROPymf39SgoJcR8oF5+4aKHaFkr7PasNGGCqiI9C+HhHa/6XIHYxEzNoi"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
