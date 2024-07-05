defmodule IntegradorNovo.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :description, :string
      add :value, :float
      add :urgency, :integer
      add :impact, :integer
      add :configuration_item_id, references(:configuration_item, on_delete: :nothing)
      add :solution_id, references(:solutions, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:events, [:configuration_item_id])
    create index(:events, [:solution_id])
  end
end
