defmodule IntegradorNovoWeb.ConfigurationItemLiveTest do
  use IntegradorNovoWeb.ConnCase

  import Phoenix.LiveViewTest
  import IntegradorNovo.ConfigurationItemsFixtures

  @create_attrs %{description: "some description", item_type: 42}
  @update_attrs %{description: "some updated description", item_type: 43}
  @invalid_attrs %{description: nil, item_type: nil}

  defp create_configuration_item(_) do
    configuration_item = configuration_item_fixture()
    %{configuration_item: configuration_item}
  end

  describe "Index" do
    setup [:create_configuration_item]

    test "lists all configuration_item", %{conn: conn, configuration_item: configuration_item} do
      {:ok, _index_live, html} = live(conn, ~p"/configuration_item")

      assert html =~ "Listing Configuration item"
      assert html =~ configuration_item.description
    end

    test "saves new configuration_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/configuration_item")

      assert index_live |> element("a", "New Configuration item") |> render_click() =~
               "New Configuration item"

      assert_patch(index_live, ~p"/configuration_item/new")

      assert index_live
             |> form("#configuration_item-form", configuration_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#configuration_item-form", configuration_item: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/configuration_item")

      html = render(index_live)
      assert html =~ "Configuration item created successfully"
      assert html =~ "some description"
    end

    test "updates configuration_item in listing", %{conn: conn, configuration_item: configuration_item} do
      {:ok, index_live, _html} = live(conn, ~p"/configuration_item")

      assert index_live |> element("#configuration_item-#{configuration_item.id} a", "Edit") |> render_click() =~
               "Edit Configuration item"

      assert_patch(index_live, ~p"/configuration_item/#{configuration_item}/edit")

      assert index_live
             |> form("#configuration_item-form", configuration_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#configuration_item-form", configuration_item: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/configuration_item")

      html = render(index_live)
      assert html =~ "Configuration item updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes configuration_item in listing", %{conn: conn, configuration_item: configuration_item} do
      {:ok, index_live, _html} = live(conn, ~p"/configuration_item")

      assert index_live |> element("#configuration_item-#{configuration_item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#configuration_item-#{configuration_item.id}")
    end
  end

  describe "Show" do
    setup [:create_configuration_item]

    test "displays configuration_item", %{conn: conn, configuration_item: configuration_item} do
      {:ok, _show_live, html} = live(conn, ~p"/configuration_item/#{configuration_item}")

      assert html =~ "Show Configuration item"
      assert html =~ configuration_item.description
    end

    test "updates configuration_item within modal", %{conn: conn, configuration_item: configuration_item} do
      {:ok, show_live, _html} = live(conn, ~p"/configuration_item/#{configuration_item}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Configuration item"

      assert_patch(show_live, ~p"/configuration_item/#{configuration_item}/show/edit")

      assert show_live
             |> form("#configuration_item-form", configuration_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#configuration_item-form", configuration_item: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/configuration_item/#{configuration_item}")

      html = render(show_live)
      assert html =~ "Configuration item updated successfully"
      assert html =~ "some updated description"
    end
  end
end
