# lib/integrador_novo_web/controllers/history_controller.ex
defmodule IntegradorNovoWeb.HistoryController do
  use IntegradorNovoWeb, :controller
  import Ecto.Query
  alias IntegradorNovo.{History, Machines.Machine, Repo}

  def create(conn, %{"history" => history_params}) do
    machine_id = history_params["machine_id"]

    # Verificar se o código da máquina existe
    case Repo.get(Machine, machine_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{success: false, message: "Machine not found"})

      machine ->
        changeset = History.changeset(%History{
          machine_id: machine.id,
          status: 0,  # Sempre define o status como 0
          cpu_usage: history_params["cpu_usage"],
          ram_usage: history_params["ram_usage"],
          disk_usage: history_params["disk_usage"],
          swap_usage: history_params["swap_usage"],
          cpu_temperature: history_params["cpu_temperature"],
          process_count: history_params["process_count"],
          cpu_frequency: history_params["cpu_frequency"]
        })

        case Repo.insert(changeset) do
          {:ok, _history} ->
            conn
            |> put_status(:created)
            |> json(%{success: true, message: "Created successfully"})

          {:error, _changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{success: false, message: "Failed to create"})
        end
    end
  end

  def history_data(conn, %{"id" => id}) do
    IO.inspect(id, label: "TESTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE")
    case fetch_updated_history_data(id) do
      [] ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "No history data found for machine ID #{id}"})

      history_data ->
        machine = Repo.get!(Machine, id)
        conn
        |> put_status(:ok)
        |> json(%{machine: machine, history_data: history_data, machine_id: id})
    end
  end

  defp fetch_updated_history_data(id) do
    Repo.all(
      from h in History,
      where: h.machine_id == ^id and h.status != 0,
      limit: 10,
      order_by: [desc: h.id]
    )
  end
end
