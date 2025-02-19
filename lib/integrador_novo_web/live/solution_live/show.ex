defmodule IntegradorNovoWeb.SolutionLive.Show do
  use IntegradorNovoWeb, :live_view

  alias IntegradorNovo.Solutions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:solution, Solutions.get_solution!(id))}
  end

  defp page_title(:show), do: "Show Solution"
  defp page_title(:edit), do: "Edit Solution"
end
