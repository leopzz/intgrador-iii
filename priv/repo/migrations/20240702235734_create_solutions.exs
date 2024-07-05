defmodule IntegradorNovo.Repo.Migrations.CreateSolutions do
  use Ecto.Migration

  def change do
    create table(:solutions) do
      add :description, :string
      add :solution, :string

      timestamps(type: :utc_datetime)
    end
  end
end
