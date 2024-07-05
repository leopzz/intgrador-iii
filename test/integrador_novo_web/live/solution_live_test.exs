defmodule IntegradorNovoWeb.SolutionLiveTest do
  use IntegradorNovoWeb.ConnCase

  import Phoenix.LiveViewTest
  import IntegradorNovo.SolutionsFixtures

  @create_attrs %{description: "some description", solution: "some solution"}
  @update_attrs %{description: "some updated description", solution: "some updated solution"}
  @invalid_attrs %{description: nil, solution: nil}

  defp create_solution(_) do
    solution = solution_fixture()
    %{solution: solution}
  end

  describe "Index" do
    setup [:create_solution]

    test "lists all solutions", %{conn: conn, solution: solution} do
      {:ok, _index_live, html} = live(conn, ~p"/solutions")

      assert html =~ "Listing Solutions"
      assert html =~ solution.description
    end

    test "saves new solution", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/solutions")

      assert index_live |> element("a", "New Solution") |> render_click() =~
               "New Solution"

      assert_patch(index_live, ~p"/solutions/new")

      assert index_live
             |> form("#solution-form", solution: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#solution-form", solution: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/solutions")

      html = render(index_live)
      assert html =~ "Solution created successfully"
      assert html =~ "some description"
    end

    test "updates solution in listing", %{conn: conn, solution: solution} do
      {:ok, index_live, _html} = live(conn, ~p"/solutions")

      assert index_live |> element("#solutions-#{solution.id} a", "Edit") |> render_click() =~
               "Edit Solution"

      assert_patch(index_live, ~p"/solutions/#{solution}/edit")

      assert index_live
             |> form("#solution-form", solution: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#solution-form", solution: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/solutions")

      html = render(index_live)
      assert html =~ "Solution updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes solution in listing", %{conn: conn, solution: solution} do
      {:ok, index_live, _html} = live(conn, ~p"/solutions")

      assert index_live |> element("#solutions-#{solution.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#solutions-#{solution.id}")
    end
  end

  describe "Show" do
    setup [:create_solution]

    test "displays solution", %{conn: conn, solution: solution} do
      {:ok, _show_live, html} = live(conn, ~p"/solutions/#{solution}")

      assert html =~ "Show Solution"
      assert html =~ solution.description
    end

    test "updates solution within modal", %{conn: conn, solution: solution} do
      {:ok, show_live, _html} = live(conn, ~p"/solutions/#{solution}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Solution"

      assert_patch(show_live, ~p"/solutions/#{solution}/show/edit")

      assert show_live
             |> form("#solution-form", solution: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#solution-form", solution: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/solutions/#{solution}")

      html = render(show_live)
      assert html =~ "Solution updated successfully"
      assert html =~ "some updated description"
    end
  end
end
