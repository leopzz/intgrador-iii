# lib/integrador_novo/history_processor.ex
defmodule IntegradorNovo.HistoryProcessor do
  use GenServer
  alias IntegradorNovo.Events
  alias IntegradorNovo.{Repo, History}
  import Ecto.Query

  # Intervalo de 5 segundos para processamento
  @interval 5_000

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(state) do
    schedule_work()
    {:ok, state}
  end

  @impl true
  def handle_info(:work, state) do
    process_history()
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, @interval)
  end

  defp process_history do
    History
    |> where([h], h.status == 0)
    |> Repo.all()
    |> Enum.each(&process_item/1)
  end

  defp process_item(%History{} = history) do
    try do
      IO.inspect(history, label: "Processing History Item")

      history
      |> Ecto.Changeset.change(status: 1)
      |> Repo.update()

      # generate_alerts(history)

      # PubSub.broadcast(IntegradorNovo.PubSub, @pubsub_topic, {:history_processed, history})
    rescue
      _exception ->
        history
        |> Ecto.Changeset.change(status: 2)
        |> Repo.update()
    end
  end

  defp generate_alerts(%History{} = history) do
    IO.inspect(history, label: "HISOTY")

    query =
      from e in Events.Event,
        join: c in assoc(e, :configuration_item),
        select: %{e | configuration_item: c},
        order_by: [desc: (e.priority + e.urgency)]

    IO.inspect(query, label: "QUERY")

    events =
      query
      |> Repo.all()

    IO.inspect(events, label: "EVENTS")

    Enum.each(events, fn event ->
      check_event_and_create_alert(event, history)
    end)
  end

  defp check_event_and_create_alert(%Events.Event{} = event, %History{} = history) do
    IO.inspect(event, label: "VERIFICANDO ALERTA")

    case event.configuration_item do
      "ram_usage" ->
        if history.ram_usage > event.value do
          create_alert(history, event)
        end

      "cpu_usage" ->
        if history.cpu_usage > event.value do
          create_alert(history, event)
        end

      "disk_usage" ->
        if history.disk_usage > event.value do
          create_alert(history, event)
        end

      "swap_usage" ->
        if history.swap_usage > event.value do
          create_alert(history, event)
        end

      "cpu_temperature" ->
        if history.cpu_temperature > event.value do
          create_alert(history, event)
        end

      "process_count" ->
        if history.process_count > event.value do
          create_alert(history, event)
        end

      "cpu_frequency" ->
        if history.cpu_frequency > event.value do
          create_alert(history, event)
        end

      _ ->
        nil
    end
  end

  def create_alert(history, event) do
    %IntegradorNovo.Alerts.Alert{}
    |> IntegradorNovo.Alerts.Alert.changeset(%{
      machine_id: history.machine_id,
      event_id: event.id,
      description:
        "Alert triggered for machine #{history.machine_id} due to #{event.description}",
      history_id: history.id
    })
    |> Repo.insert()
  end
end
