defmodule IntegradorNovo.Repo.Migrations.CreateMachines do
  use Ecto.Migration

  def change do
    create table(:machines) do
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
