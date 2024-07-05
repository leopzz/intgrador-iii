defmodule IntegradorNovo.EventManager do
  alias IntegradorNovo.{Repo, Events.Event, Alerts.Alert}
  import Ecto.Query

  def generate_alert(history) do
    configuration_item_id = history.configuration_item_id

    event =
      Event
      |> where([e], e.configuration_item_id == ^configuration_item_id)
      |> order_by([e], desc: e.urgency + e.impact)
      |> Repo.one()

    case event do
      nil ->
        IO.puts("No matching event found for history: #{inspect(history)}")

      _ ->
        if event_matches_criteria(history, event) do
          create_alert(history, event)
        end
    end
  end

  defp event_matches_criteria(history, event) do
    case event.description do
      "cpu_usage" ->
        history.cpu_usage > event.value

      "ram_usage" ->
        history.ram_usage > event.value

      "disk_usage" ->
        history.disk_usage > event.value

      "swap_usage" ->
        history.swap_usage > event.value

      "cpu_temperature" ->
        history.cpu_temperature > event.value

      "process_count" ->
        history.process_count > event.value

      "cpu_frequency" ->
        history.cpu_frequency > event.value

      _ ->
        false
    end
  end

  defp create_alert(history, event) do
    Repo.insert(%Alert{
      machine_id: history.machine_id,
      event_id: event.id,
      description: "Alert generated for #{event.description}"
    })
  end

  def list_alerts_with_event_data() do
    query =
      from a in Alert,
        join: e in assoc(a, :event),
        join: h in assoc(a, :history),
        select: %{a | event: e, history: h},
        order_by: [desc: e.urgency + e.impact]

    alerts =
      query
      |> Repo.all()

    {alerts, length(alerts)}
  end
end
