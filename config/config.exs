# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :my_site,
  ecto_repos: [MySite.Repo]

# Configures the endpoint
config :my_site, MySiteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "m8oHXXWgFobIvb6GzzO0/puDS9G61sor6TR5kujJ9YUmq8ik8jRbjcjKVxPRDBUY",
  render_errors: [view: MySiteWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MySite.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
