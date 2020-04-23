# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :spider,
  ecto_repos: [Spider.Repo]

# Configures the endpoint
config :spider, SpiderWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "azFxZsvIn3FfpkdQVTdk2Qbrz/guhCQj7Csh6pE92r0aulE97QPNrIDmUr59fv/l",
  render_errors: [
    view: SpiderWeb.ErrorView, 
    accepts: ~w(html json)
    ],
  pubsub: [
            name: Spider.PubSub,
            adapter: Phoenix.PubSub.PG2
          ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Guardian Authentication
config :spider, Spider.Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "spider",
  ttl: {30, :minutes},
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "CBmqCdkBw8jOSlGzi6A0WdhDyU1N03W5oc3hoks9xVgS+0u/muUsmPkfTRBVy6ki"


config :arc,
  storage: Arc.Storage.Local, # or  Arc.Storage.S3
  # bucket: {:system, "AWS_S3_BUCKET"} # if using Amazon S3

# config :cors_plug,
#   origin: ["http://localhost:8081"],
#   max_age: 86400,
#   methods: ["GET", "POST", "PUT", "DELETE"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
