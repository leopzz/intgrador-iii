defmodule IntegradorNovoWeb.MachineLiveTest do
  use IntegradorNovoWeb.ConnCase

  import Phoenix.LiveViewTest
  import IntegradorNovo.MachinesFixtures

  @create_attrs %{description: "some description"}
  @update_attrs %{description: "some updated description"}
  @invalid_attrs %{description: nil}

  defp create_machine(_) do
    machine = machine_fixture()
    %{machine: machine}
  end

  describe "Index" do
    setup [:create_machine]

    test "lists all machines", %{conn: conn, machine: machine} do
      {:ok, _index_live, html} = live(conn, ~p"/machines")

      assert html =~ "Listing Machines"
      assert html =~ machine.description
    end

    test "saves new machine", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/machines")

      assert index_live |> element("a", "New Machine") |> render_click() =~
               "New Machine"

      assert_patch(index_live, ~p"/machines/new")

      assert index_live
             |> form("#machine-form", machine: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#machine-form", machine: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/machines")

      html = render(index_live)
      assert html =~ "Machine created successfully"
      assert html =~ "some description"
    end

    test "updates machine in listing", %{conn: conn, machine: machine} do
      {:ok, index_live, _html} = live(conn, ~p"/machines")

      assert index_live |> element("#machines-#{machine.id} a", "Edit") |> render_click() =~
               "Edit Machine"

      assert_patch(index_live, ~p"/machines/#{machine}/edit")

      assert index_live
             |> form("#machine-form", machine: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#machine-form", machine: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/machines")

      html = render(index_live)
      assert html =~ "Machine updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes machine in listing", %{conn: conn, machine: machine} do
      {:ok, index_live, _html} = live(conn, ~p"/machines")

      assert index_live |> element("#machines-#{machine.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#machines-#{machine.id}")
    end
  end

  describe "Show" do
    setup [:create_machine]

    test "displays machine", %{conn: conn, machine: machine} do
      {:ok, _show_live, html} = live(conn, ~p"/machines/#{machine}")

      assert html =~ "Show Machine"
      assert html =~ machine.description
    end

    test "updates machine within modal", %{conn: conn, machine: machine} do
      {:ok, show_live, _html} = live(conn, ~p"/machines/#{machine}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Machine"

      assert_patch(show_live, ~p"/machines/#{machine}/show/edit")

      assert show_live
             |> form("#machine-form", machine: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#machine-form", machine: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/machines/#{machine}")

      html = render(show_live)
      assert html =~ "Machine updated successfully"
      assert html =~ "some updated description"
    end
  end
end
