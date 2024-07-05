defmodule IntegradorNovoWeb.AlertsLive.Index do
  use IntegradorNovoWeb, :live_view

  alias IntegradorNovo.EventManager

  def render(assigns) do
    ~H"""
    <div>
      <h2>List of Alerts</h2>

      <%= for alert <- @alerts do %>
        <div>
          <p>Description: <%= alert.description %></p>
          <p>Machine: <%= alert.machine.name %></p>
          <p>Event: <%= alert.event.name %></p>
        </div>
      <% end %>

    </div>
    """
  end

  def mount(_params, _session, socket) do
    machines = IntegradorNovo.Machines.Machine.list_machines()
    {:ok, assign(socket, machines: machines)}
  end

  def handle_params(_params, _url, socket) do
    filter_and_update(socket)
  end

  defp filter_and_update(socket) do
    {alerts, total_count} = EventManager.list_alerts_with_event_data()
    {:noreply, assign(socket, alerts: alerts, total_count: total_count)}
  end
end
