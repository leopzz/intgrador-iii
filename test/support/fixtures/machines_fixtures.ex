defmodule IntegradorNovo.MachinesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IntegradorNovo.Machines` context.
  """

  @doc """
  Generate a machine.
  """
  def machine_fixture(attrs \\ %{}) do
    {:ok, machine} =
      attrs
      |> Enum.into(%{
        description: "some description"
      })
      |> IntegradorNovo.Machines.create_machine()

    machine
  end
end
