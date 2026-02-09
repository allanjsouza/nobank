defmodule Nobank.Repo do
  use Ecto.Repo,
    otp_app: :nobank,
    adapter: Ecto.Adapters.Postgres
end
