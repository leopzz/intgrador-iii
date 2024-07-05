defmodule IntegradorNovo.Repo.Migrations.CreateAlertsTable do
  use Ecto.Migration

  def change do
    create table(:alerts) do
      add :machine_id, references(:machines, on_delete: :delete_all)
      add :event_id, references(:events, on_delete: :delete_all)
      add :description, :string
      add :history_id, references(:history, on_delete: :delete_all)

      timestamps()
    end

    create index(:alerts, [:machine_id])
    create index(:alerts, [:event_id])
  end
end
