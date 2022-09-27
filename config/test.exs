import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :coin_master, CoinMasterWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "7p5ZXEjwKKMXrp0whlLHuUBC5QEPH5sM5XWFVzJUAXJKBwR8+eB0JEadfwc+DIAf",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
