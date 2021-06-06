defmodule SafebodaFullstack.Repo do
  use Ecto.Repo,
    otp_app: :safeboda_fullstack,
    adapter: Ecto.Adapters.Postgres

  use Paginator
end
