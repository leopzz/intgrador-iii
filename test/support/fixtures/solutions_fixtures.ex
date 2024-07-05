defmodule IntegradorNovo.SolutionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IntegradorNovo.Solutions` context.
  """

  @doc """
  Generate a solution.
  """
  def solution_fixture(attrs \\ %{}) do
    {:ok, solution} =
      attrs
      |> Enum.into(%{
        description: "some description",
        solution: "some solution"
      })
      |> IntegradorNovo.Solutions.create_solution()

    solution
  end
end
