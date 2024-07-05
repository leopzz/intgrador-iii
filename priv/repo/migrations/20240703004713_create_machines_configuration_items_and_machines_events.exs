defmodule IntegradorNovo.Repo.Migrations.CreateMachinesConfigurationItemsAndMachinesEvents do
  use Ecto.Migration

  def change do
    create table(:machines_configuration_items) do
      add :machine_id, references(:machines, on_delete: :delete_all)
      add :configuration_item_id, references(:configuration_item, on_delete: :delete_all)

      timestamps()
    end

    create index(:machines_configuration_items, [:machine_id])
    create index(:machines_configuration_items, [:configuration_item_id])

    create table(:machines_events) do
      add :machine_id, references(:machines, on_delete: :delete_all)
      add :event_id, references(:events, on_delete: :delete_all)

      timestamps()
    end

    create index(:machines_events, [:machine_id])
    create index(:machines_events, [:event_id])
  end
end
