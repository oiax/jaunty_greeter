defmodule JauntyGreeter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JauntyGreeterWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:jaunty_greeter, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: JauntyGreeter.PubSub},
      # Start a worker by calling: JauntyGreeter.Worker.start_link(arg)
      # {JauntyGreeter.Worker, arg},
      # Start to serve requests, typically the last entry
      JauntyGreeterWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JauntyGreeter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JauntyGreeterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
