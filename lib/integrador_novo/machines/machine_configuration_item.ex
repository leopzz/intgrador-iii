defmodule IntegradorNovo.Machines.MachineConfigurationItem do
  use Ecto.Schema

  schema "machines_configuration_items" do
    belongs_to :machines, IntegradorNovo.Machines.Machine
    belongs_to :configuration_item, IntegradorNovo.ConfigurationItems.ConfigurationItem

    timestamps()
  end
end
