defmodule IntegradorNovoWeb.MachineLive.FormComponent do
  use IntegradorNovoWeb, :live_component

  alias IntegradorNovo.Machines
  alias IntegradorNovo.Repo
  require IEx

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage machine records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="machine-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:configuration_item_ids]} type="select" label="Configuration Items" multiple options={@configuration_items_options} />
        <.input field={@form[:event_ids]} type="select" label="Events" multiple options={@events_options} />

        <:actions>
          <.button phx-disable-with="Saving...">Save Machine</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{machine: machine} = assigns, socket) do
    IO.inspect("TESTE")
    configuration_items = Repo.all(IntegradorNovo.ConfigurationItems.ConfigurationItem) || []
    events = Repo.all(IntegradorNovo.Events.Event) || []

    configuration_items_options = Enum.map(configuration_items, &{&1.description, &1.id})
    events_options = Enum.map(events, &{&1.description, &1.id})

    IO.inspect(events_options, label: "events")
    IO.inspect(configuration_items_options, label: "configuration")

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:configuration_items_options, configuration_items_options)
     |> assign(:events_options, events_options)
     |> assign_new(:form, fn ->
       to_form(Machines.change_machine(machine))
     end)}
  end

  @impl true
  def handle_event("validate", %{"machine" => machine_params}, socket) do
    changeset = Machines.change_machine(socket.assigns.machine, machine_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"machine" => machine_params}, socket) do
    IO.inspect(machine_params, label: "Machine Parameters")
    save_machine(socket, socket.assigns.action, machine_params)
  end

  defp save_machine(socket, :edit, machine_params) do
    case Machines.update_machine(socket.assigns.machine, machine_params) do
      {:ok, machine} ->
        notify_parent({:saved, machine})

        {:noreply,
         socket
         |> put_flash(:info, "Machine updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_machine(socket, :new, machine_params) do
    case Machines.create_machine(machine_params) do
      {:ok, machine} ->
        notify_parent({:saved, machine})

        {:noreply,
         socket
         |> put_flash(:info, "Machine created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
