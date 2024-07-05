defmodule IntegradorNovo.ConfigurationItems do
  @moduledoc """
  The ConfigurationItems context.
  """

  import Ecto.Query, warn: false
  alias IntegradorNovo.Repo

  alias IntegradorNovo.ConfigurationItems.ConfigurationItem

  @doc """
  Returns the list of configuration_item.

  ## Examples

      iex> list_configuration_item()
      [%ConfigurationItem{}, ...]

  """
  def list_configuration_item do
    Repo.all(ConfigurationItem)
  end

  @doc """
  Gets a single configuration_item.

  Raises `Ecto.NoResultsError` if the Configuration item does not exist.

  ## Examples

      iex> get_configuration_item!(123)
      %ConfigurationItem{}

      iex> get_configuration_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_configuration_item!(id), do: Repo.get!(ConfigurationItem, id)

  @doc """
  Creates a configuration_item.

  ## Examples

      iex> create_configuration_item(%{field: value})
      {:ok, %ConfigurationItem{}}

      iex> create_configuration_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_configuration_item(attrs \\ %{}) do
    %ConfigurationItem{}
    |> ConfigurationItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a configuration_item.

  ## Examples

      iex> update_configuration_item(configuration_item, %{field: new_value})
      {:ok, %ConfigurationItem{}}

      iex> update_configuration_item(configuration_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_configuration_item(%ConfigurationItem{} = configuration_item, attrs) do
    configuration_item
    |> ConfigurationItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a configuration_item.

  ## Examples

      iex> delete_configuration_item(configuration_item)
      {:ok, %ConfigurationItem{}}

      iex> delete_configuration_item(configuration_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_configuration_item(%ConfigurationItem{} = configuration_item) do
    Repo.delete(configuration_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking configuration_item changes.

  ## Examples

      iex> change_configuration_item(configuration_item)
      %Ecto.Changeset{data: %ConfigurationItem{}}

  """
  def change_configuration_item(%ConfigurationItem{} = configuration_item, attrs \\ %{}) do
    ConfigurationItem.changeset(configuration_item, attrs)
  end
end
