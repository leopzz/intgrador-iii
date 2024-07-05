defmodule IntegradorNovo.Repo.Migrations.CreateHistory do
  use Ecto.Migration

  def change do
    create table(:history) do
      add :machine_id, references(:machines, on_delete: :delete_all)
      add :status, :integer
      add :cpu_usage, :float
      add :ram_usage, :float
      add :disk_usage, :float
      add :swap_usage, :float
      add :cpu_temperature, :float
      add :process_count, :integer
      add :cpu_frequency, :float

      timestamps()
    end
  end
end
