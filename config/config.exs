# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :dashboard, DashboardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a4b8/lROOb5rNMvZWmWfQYwKxv398hxF+U+0hXlOpSADtn9gkjLOMhvzBHhmAKVI",
  render_errors: [view: DashboardWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dashboard.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures the pingdom client
config :dashboard, :pingdom, []

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

try do
  import_config "#{Mix.env}.secret.exs"
rescue
  Mix.Config.LoadError -> IO.puts("No secrets config found for #{Mix.env}")
end
