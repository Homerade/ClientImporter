defmodule ClientImporter.Repo do
  use Ecto.Repo,
    otp_app: :client_importer,
    adapter: Ecto.Adapters.Postgres
end
