defmodule IntegradorNovo.Solutions do
  @moduledoc """
  The Solutions context.
  """

  import Ecto.Query, warn: false
  alias IntegradorNovo.Repo

  alias IntegradorNovo.Solutions.Solution

  @doc """
  Returns the list of solutions.

  ## Examples

      iex> list_solutions()
      [%Solution{}, ...]

  """
  def list_solutions do
    Repo.all(Solution)
  end

  @doc """
  Gets a single solution.

  Raises `Ecto.NoResultsError` if the Solution does not exist.

  ## Examples

      iex> get_solution!(123)
      %Solution{}

      iex> get_solution!(456)
      ** (Ecto.NoResultsError)

  """
  def get_solution!(id), do: Repo.get!(Solution, id)

  @doc """
  Creates a solution.

  ## Examples

      iex> create_solution(%{field: value})
      {:ok, %Solution{}}

      iex> create_solution(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_solution(attrs \\ %{}) do
    %Solution{}
    |> Solution.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a solution.

  ## Examples

      iex> update_solution(solution, %{field: new_value})
      {:ok, %Solution{}}

      iex> update_solution(solution, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_solution(%Solution{} = solution, attrs) do
    solution
    |> Solution.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a solution.

  ## Examples

      iex> delete_solution(solution)
      {:ok, %Solution{}}

      iex> delete_solution(solution)
      {:error, %Ecto.Changeset{}}

  """
  def delete_solution(%Solution{} = solution) do
    Repo.delete(solution)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking solution changes.

  ## Examples

      iex> change_solution(solution)
      %Ecto.Changeset{data: %Solution{}}

  """
  def change_solution(%Solution{} = solution, attrs \\ %{}) do
    Solution.changeset(solution, attrs)
  end
end
