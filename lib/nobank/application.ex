defmodule Nobank.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NobankWeb.Telemetry,
      Nobank.Repo,
      {DNSCluster, query: Application.get_env(:nobank, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Nobank.PubSub},
      # Start a worker by calling: Nobank.Worker.start_link(arg)
      # {Nobank.Worker, arg},
      # Start to serve requests, typically the last entry
      NobankWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nobank.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NobankWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
