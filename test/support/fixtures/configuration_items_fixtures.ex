defmodule IntegradorNovo.ConfigurationItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IntegradorNovo.ConfigurationItems` context.
  """

  @doc """
  Generate a configuration_item.
  """
  def configuration_item_fixture(attrs \\ %{}) do
    {:ok, configuration_item} =
      attrs
      |> Enum.into(%{
        description: "some description",
        item_type: 42
      })
      |> IntegradorNovo.ConfigurationItems.create_configuration_item()

    configuration_item
  end
end
