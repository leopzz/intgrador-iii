defmodule IntegradorNovoWeb.MachineLive.Index do
  use IntegradorNovoWeb, :live_view

  alias IntegradorNovo.Machines
  alias IntegradorNovo.Machines.Machine

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :machines, Machines.list_machines())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Machine")
    |> assign(:machine, Machines.get_machine!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Machine")
    |> assign(:machine, %Machine{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Machines")
    |> assign(:machine, nil)
  end

  @impl true
  def handle_info({IntegradorNovoWeb.MachineLive.FormComponent, {:saved, machine}}, socket) do
    {:noreply, stream_insert(socket, :machines, machine)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    machine = Machines.get_machine!(id)
    {:ok, _} = Machines.delete_machine(machine)

    {:noreply, stream_delete(socket, :machines, machine)}
  end
end
