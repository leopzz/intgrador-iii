defmodule IntegradorNovo.Repo do
  use Ecto.Repo,
    otp_app: :integrador_novo,
    adapter: Ecto.Adapters.Postgres
end
