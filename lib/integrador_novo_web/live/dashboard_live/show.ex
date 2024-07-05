defmodule IntegradorNovoWeb.DashboardLive.Show do
  use IntegradorNovoWeb, :live_view
  import Ecto.Query
  alias IntegradorNovo.{Repo, History}
  alias Phoenix.PubSub
  import Phoenix.Controller

  @pubsub_topic "history_updates"

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket), do: PubSub.subscribe(IntegradorNovo.PubSub, @pubsub_topic)

    machine = Repo.get!(IntegradorNovo.Machines.Machine, id)

    history_data = fetch_initial_history_data(id)

    IO.inspect(history_data, label: "data")

    {:ok, assign(socket, machine: machine, history_data: history_data, machine_id: id)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:machine, Repo.get!(IntegradorNovo.Machines.Machine, id))}
  end

  @impl true
  def handle_info({:history_processed, history}, socket) do
    machine = Repo.get!(IntegradorNovo.Machines.Machine, history.machine_id)
    history_data = fetch_updated_history_data(history.machine_id)

    IO.inspect(history_data, label: "HISTORY DATA")
    {:noreply, assign(socket, machine: machine, history_data: history_data)}
  end

  def history_data(conn, %{"id" => id}) do
    history_data = fetch_updated_history_data(id)
    json(conn, history_data)
  end

  defp fetch_initial_history_data(id) do
    Repo.all(
      from h in History,
      where: h.machine_id == ^id and h.status == 1,
      limit: 10,
      order_by: [desc: h.id]
    )
  end

  defp fetch_updated_history_data(id) do
    fetch_initial_history_data(id)
  end

  defp page_title(:show), do: "Show Machine"
  defp page_title(:edit), do: "Edit Machine"
end
