defmodule IntegradorNovoWeb.SolutionLive.FormComponent do
  use IntegradorNovoWeb, :live_component

  alias IntegradorNovo.Solutions

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage solution records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="solution-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:solution]} type="text" label="Solution" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Solution</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{solution: solution} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Solutions.change_solution(solution))
     end)}
  end

  @impl true
  def handle_event("validate", %{"solution" => solution_params}, socket) do
    changeset = Solutions.change_solution(socket.assigns.solution, solution_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"solution" => solution_params}, socket) do
    save_solution(socket, socket.assigns.action, solution_params)
  end

  defp save_solution(socket, :edit, solution_params) do
    case Solutions.update_solution(socket.assigns.solution, solution_params) do
      {:ok, solution} ->
        notify_parent({:saved, solution})

        {:noreply,
         socket
         |> put_flash(:info, "Solution updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_solution(socket, :new, solution_params) do
    case Solutions.create_solution(solution_params) do
      {:ok, solution} ->
        notify_parent({:saved, solution})

        {:noreply,
         socket
         |> put_flash(:info, "Solution created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
