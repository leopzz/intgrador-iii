defmodule IntegradorNovo.ConfigurationItems.ConfigurationItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "configuration_item" do
    field :description, :string
    field :item_type, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(configuration_item, attrs) do
    configuration_item
    |> cast(attrs, [:description, :item_type])
    |> validate_required([:description, :item_type])
  end
end
