# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :coin_master, CoinMasterWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: CoinMasterWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CoinMaster.PubSub,
  live_view: [signing_salt: "wlvXtMKy"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :coin_master,
  facebook_chat_bot: %{
    base_url: "https://graph.facebook.com",
    message_url: "me/messages",
    api_version: "v14.0",
    page_access_token: System.get_env("FACEBOOK_PAGE_ACCESS_TOKEN"),
    webhook_verify_token: System.get_env("FACEBOOK_WEBHOOK_VERIFY_TOKEN")
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
