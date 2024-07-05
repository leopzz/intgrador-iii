defmodule IntegradorNovo.ConfigurationItemsTest do
  use IntegradorNovo.DataCase

  alias IntegradorNovo.ConfigurationItems

  describe "configuration_item" do
    alias IntegradorNovo.ConfigurationItems.ConfigurationItem

    import IntegradorNovo.ConfigurationItemsFixtures

    @invalid_attrs %{description: nil, item_type: nil}

    test "list_configuration_item/0 returns all configuration_item" do
      configuration_item = configuration_item_fixture()
      assert ConfigurationItems.list_configuration_item() == [configuration_item]
    end

    test "get_configuration_item!/1 returns the configuration_item with given id" do
      configuration_item = configuration_item_fixture()
      assert ConfigurationItems.get_configuration_item!(configuration_item.id) == configuration_item
    end

    test "create_configuration_item/1 with valid data creates a configuration_item" do
      valid_attrs = %{description: "some description", item_type: 42}

      assert {:ok, %ConfigurationItem{} = configuration_item} = ConfigurationItems.create_configuration_item(valid_attrs)
      assert configuration_item.description == "some description"
      assert configuration_item.item_type == 42
    end

    test "create_configuration_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ConfigurationItems.create_configuration_item(@invalid_attrs)
    end

    test "update_configuration_item/2 with valid data updates the configuration_item" do
      configuration_item = configuration_item_fixture()
      update_attrs = %{description: "some updated description", item_type: 43}

      assert {:ok, %ConfigurationItem{} = configuration_item} = ConfigurationItems.update_configuration_item(configuration_item, update_attrs)
      assert configuration_item.description == "some updated description"
      assert configuration_item.item_type == 43
    end

    test "update_configuration_item/2 with invalid data returns error changeset" do
      configuration_item = configuration_item_fixture()
      assert {:error, %Ecto.Changeset{}} = ConfigurationItems.update_configuration_item(configuration_item, @invalid_attrs)
      assert configuration_item == ConfigurationItems.get_configuration_item!(configuration_item.id)
    end

    test "delete_configuration_item/1 deletes the configuration_item" do
      configuration_item = configuration_item_fixture()
      assert {:ok, %ConfigurationItem{}} = ConfigurationItems.delete_configuration_item(configuration_item)
      assert_raise Ecto.NoResultsError, fn -> ConfigurationItems.get_configuration_item!(configuration_item.id) end
    end

    test "change_configuration_item/1 returns a configuration_item changeset" do
      configuration_item = configuration_item_fixture()
      assert %Ecto.Changeset{} = ConfigurationItems.change_configuration_item(configuration_item)
    end
  end
end
