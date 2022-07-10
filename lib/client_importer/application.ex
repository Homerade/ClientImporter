defmodule ClientImporter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ClientImporter.Repo,
      # Start the Telemetry supervisor
      ClientImporterWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ClientImporter.PubSub},
      # Start the Endpoint (http/https)
      ClientImporterWeb.Endpoint
      # Start a worker by calling: ClientImporter.Worker.start_link(arg)
      # {ClientImporter.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ClientImporter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ClientImporterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
