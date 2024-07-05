defmodule IntegradorNovo.History do
  use Ecto.Schema

  @derive {Jason.Encoder, only: [:id, :machine_id, :status, :cpu_usage, :ram_usage, :disk_usage, :swap_usage, :cpu_temperature, :process_count, :cpu_frequency]}

  schema "history" do
    field :machine_id, :integer  # Adicionando machine_id como um campo
    field :status, :integer
    field :cpu_usage, :float
    field :ram_usage, :float
    field :disk_usage, :float
    field :swap_usage, :float
    field :cpu_temperature, :float
    field :process_count, :integer
    field :cpu_frequency, :float

    timestamps()
  end

  def changeset(history) do
    history
  end

end
