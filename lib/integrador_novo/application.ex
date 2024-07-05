defmodule IntegradorNovo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      IntegradorNovoWeb.Telemetry,
      IntegradorNovo.Repo,
      {DNSCluster, query: Application.get_env(:integrador_novo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: IntegradorNovo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: IntegradorNovo.Finch},
      # Start a worker by calling: IntegradorNovo.Worker.start_link(arg)
      # {IntegradorNovo.Worker, arg},
      # Start to serve requests, typically the last entry
      IntegradorNovoWeb.Endpoint,
      IntegradorNovo.HistoryProcessor  # Adicionando o HistoryProcessor ao Supervisor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IntegradorNovo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IntegradorNovoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
