defmodule IntegradorNovo.Alerts.Alert do
  use Ecto.Schema
  import Ecto.Changeset

  schema "alerts" do
    field :description, :string
    belongs_to :machine, IntegradorNovo.Machines.Machine
    belongs_to :event, IntegradorNovo.Events.Event
    belongs_to :history, IntegradorNovo.History

    timestamps()
  end

  def changeset(alert, attrs) do
    alert
    |> cast(attrs, [:machine_id, :event_id, :description])
    |> validate_required([:machine_id, :event_id, :description])
  end
end
