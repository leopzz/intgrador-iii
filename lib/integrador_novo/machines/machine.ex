defmodule IntegradorNovo.Machines.Machine do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @derive {Jason.Encoder, only: [:id, :description]}

  schema "machines" do
    field :description, :string

    many_to_many :configuration_item, IntegradorNovo.ConfigurationItems.ConfigurationItem, join_through: "machines_configuration_items"
    many_to_many :events, IntegradorNovo.Events.Event, join_through: "machines_events"

    timestamps(type: :utc_datetime)
  end

  @spec changeset(
          {map(), map()}
          | %{
              :__struct__ => atom() | %{:__changeset__ => map(), optional(any()) => any()},
              optional(atom()) => any()
            }
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(machine, attrs \\ %{}) do
    machine
    |> cast(attrs, [:description])
    |> put_assoc(:events, parse_events_ids(attrs["event_ids"]))
    |> put_assoc(:configuration_item, parse_configuration_items_ids(attrs["configuration_items_ids"]))
    |> validate_required([:description])
  end

  defp parse_events_ids(nil), do: []
  defp parse_events_ids(ids) do
    ids
    |> Enum.map(&IntegradorNovo.Repo.get_by!(IntegradorNovo.Events.Event, id: &1))
  end

  defp parse_configuration_items_ids(nil), do: []
  defp parse_configuration_items_ids(ids) do
    ids
    |> Enum.map(&IntegradorNovo.Repo.get_by!(IntegradorNovo.ConfigurationItems.ConfigurationItem, id: &1))
  end

  def list_machines() do
    query = from(m in __MODULE__, select: %{id: m.id, description: m.description})
    IntegradorNovo.Repo.all(query)
  end
end
