defmodule IntegradorNovoWeb.UserSocket do
  use Phoenix.Socket

  channel "alerts:*", IntegradorNovoWeb.AlertChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
