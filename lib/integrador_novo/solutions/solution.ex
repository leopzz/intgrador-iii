defmodule IntegradorNovo.Solutions.Solution do
  use Ecto.Schema
  import Ecto.Changeset

  schema "solutions" do
    field :description, :string
    field :solution, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(solution, attrs) do
    solution
    |> cast(attrs, [:description, :solution])
    |> validate_required([:description, :solution])
  end
end
