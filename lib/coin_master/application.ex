defmodule CoinMaster.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = children(Mix.env())
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CoinMaster.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CoinMasterWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def children(:test) do
    [
      # Start the Telemetry supervisor
      CoinMasterWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CoinMaster.PubSub},
      # Start the Endpoint (http/https)
      CoinMasterWeb.Endpoint
      # Start a worker by calling: CoinMaster.Worker.start_link(arg)
      # {CoinMaster.Worker, arg}
    ]
  end

  def children(_) do
    children(:test) ++
      [
        # Setting Get started Button
        {CoinMaster.Facebook.SetGetStarted, %{}}
      ]
  end
end
