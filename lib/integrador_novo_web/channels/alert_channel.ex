defmodule IntegradorNovoWeb.AlertChannel do
  use Phoenix.Channel

  def join("alerts:" <> _machine_id, _message, socket) do
    {:ok, socket}
  end

  def handle_info({:alert_generated, machine_id, event_description}, socket) do
    push(socket, "new_alert", %{machine_id: machine_id, event_description: event_description})
    {:noreply, socket}
  end
end
