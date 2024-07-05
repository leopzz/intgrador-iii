defmodule IntegradorNovo.Repo.Migrations.CreateConfigurationItem do
  use Ecto.Migration

  def change do
    create table(:configuration_item) do
      add :description, :string
      add :item_type, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
