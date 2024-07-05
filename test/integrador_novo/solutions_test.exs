defmodule IntegradorNovo.SolutionsTest do
  use IntegradorNovo.DataCase

  alias IntegradorNovo.Solutions

  describe "solutions" do
    alias IntegradorNovo.Solutions.Solution

    import IntegradorNovo.SolutionsFixtures

    @invalid_attrs %{description: nil, solution: nil}

    test "list_solutions/0 returns all solutions" do
      solution = solution_fixture()
      assert Solutions.list_solutions() == [solution]
    end

    test "get_solution!/1 returns the solution with given id" do
      solution = solution_fixture()
      assert Solutions.get_solution!(solution.id) == solution
    end

    test "create_solution/1 with valid data creates a solution" do
      valid_attrs = %{description: "some description", solution: "some solution"}

      assert {:ok, %Solution{} = solution} = Solutions.create_solution(valid_attrs)
      assert solution.description == "some description"
      assert solution.solution == "some solution"
    end

    test "create_solution/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Solutions.create_solution(@invalid_attrs)
    end

    test "update_solution/2 with valid data updates the solution" do
      solution = solution_fixture()
      update_attrs = %{description: "some updated description", solution: "some updated solution"}

      assert {:ok, %Solution{} = solution} = Solutions.update_solution(solution, update_attrs)
      assert solution.description == "some updated description"
      assert solution.solution == "some updated solution"
    end

    test "update_solution/2 with invalid data returns error changeset" do
      solution = solution_fixture()
      assert {:error, %Ecto.Changeset{}} = Solutions.update_solution(solution, @invalid_attrs)
      assert solution == Solutions.get_solution!(solution.id)
    end

    test "delete_solution/1 deletes the solution" do
      solution = solution_fixture()
      assert {:ok, %Solution{}} = Solutions.delete_solution(solution)
      assert_raise Ecto.NoResultsError, fn -> Solutions.get_solution!(solution.id) end
    end

    test "change_solution/1 returns a solution changeset" do
      solution = solution_fixture()
      assert %Ecto.Changeset{} = Solutions.change_solution(solution)
    end
  end
end
