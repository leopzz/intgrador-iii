defmodule IntegradorNovoWeb.AuthErrorHandler do
  use IntegradorNovoWeb, :controller

  def call(conn, {:error, :unauthenticated}) do
    conn
    |> redirect(to: "/session/new")
    |> halt()
  end

  def call(conn, {:error, _reason}) do
    conn
    |> redirect(to: "/session/new")
    |> halt()
  end
  def call(conn, _) do
    conn
    |> redirect(to: "/session/new")
    |> halt()
  end
end
