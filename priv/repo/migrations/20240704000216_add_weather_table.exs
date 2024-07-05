defmodule IntegradorNovo.Repo.Migrations.AddWeatherTable do
  use Ecto.Migration

  def change do
    alter table("machines_events") do
      remove :updated_at
      remove :inserted_at
    end
    alter table("machines_configuration_items") do
      remove :updated_at
      remove :inserted_at
    end
  end
end
