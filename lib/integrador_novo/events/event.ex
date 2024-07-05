defmodule IntegradorNovo.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :value, :float
    field :description, :string
    field :urgency, :integer
    field :impact, :integer
    belongs_to :configuration_item, IntegradorNovo.ConfigurationItens.ConfigurationItem
    belongs_to :solution, IntegradorNovo.Solutions.Solution

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:description, :value, :urgency, :impact])
    |> validate_required([:description, :value, :urgency, :impact])
  end
end
