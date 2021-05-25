defmodule SafebodaFullstack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SafebodaFullstack.Repo,
      # Start the Telemetry supervisor
      SafebodaFullstackWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SafebodaFullstack.PubSub},
      # Start the Endpoint (http/https)
      SafebodaFullstackWeb.Endpoint
      # Start a worker by calling: SafebodaFullstack.Worker.start_link(arg)
      # {SafebodaFullstack.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SafebodaFullstack.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SafebodaFullstackWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
