defmodule IntegradorNovo.Machines.MachineEvent do
  use Ecto.Schema

  schema "machines_events" do
    belongs_to :machines, IntegradorNovo.Machines.Machine
    belongs_to :event, IntegradorNovo.Events.Event

    timestamps()
  end
end
