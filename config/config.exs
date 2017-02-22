# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :uphill_rating, UphillRating.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "CwW8BISPVW4UIDeVu7w5mJ/XY312IjTNcPaHXZYRooq2nQFhCsrWtTd81JLyoGjX",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: UphillRating.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :ex_admin,
  repo: UphillRating.Repo,
  module: UphillRating,
  modules: [
    UphillRating.ExAdmin.Dashboard,
    UphillRating.ExAdmin.Team,
    UphillRating.ExAdmin.Bicyclist,
    UphillRating.ExAdmin.Race,
    UphillRating.ExAdmin.BicyclistRace,
  ]

config :xain, :after_callback, {Phoenix.HTML, :raw}

config :uphill_rating, ecto_repos: [UphillRating.Repo]
