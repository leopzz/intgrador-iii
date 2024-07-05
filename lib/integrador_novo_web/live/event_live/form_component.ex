defmodule IntegradorNovoWeb.EventLive.FormComponent do
  use IntegradorNovoWeb, :live_component

  alias IntegradorNovo.Events

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage event records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="event-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:value]} type="number" label="Value" step="any" />
        <.input field={@form[:urgency]} type="select" label="Urgency" options={@urgency_options}/>
        <.input field={@form[:impact]} type="select" label="Impact" options={@impact_options}/>
        <.input field={@form[:configuration_item_id]} type="select" label="Configuration Item" options={@configuration_items} />
        <.input field={@form[:solution_id]} type="select" label="Solution" options={@solutions} />



        <:actions>
          <.button phx-disable-with="Saving...">Save Event</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{event: event} = assigns, socket) do

    configuration_items = IntegradorNovo.ConfigurationItems.ConfigurationItem |> IntegradorNovo.Repo.all()
    solutions = IntegradorNovo.Solutions.Solution |> IntegradorNovo.Repo.all()
    urgency_options = [
      {"Não urgente", 1},
      {"Pouco urgente", 2},
      {"Urgente", 3},
      {"Muito urgente", 4},
      {"Imediato", 5}
    ]

    impact_options = [
      {"Sem impacto", 1},
      {"Leve", 2},
      {"Médio", 3},
      {"Grave", 4},
      {"Gravíssimo", 5}
    ]
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:configuration_items, Enum.map(configuration_items, fn item -> {item.description, item.id} end))
     |> assign(:solutions, Enum.map(solutions, fn solution -> {solution.description, solution.id} end))
     |> assign(:urgency_options, urgency_options)
     |> assign(:impact_options, impact_options)
     |> assign_new(:form, fn ->
       to_form(Events.change_event(event))
     end)}
  end

  @impl true
  def handle_event("validate", %{"event" => event_params}, socket) do
    changeset = Events.change_event(socket.assigns.event, event_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"event" => event_params}, socket) do
    save_event(socket, socket.assigns.action, event_params)
  end

  defp save_event(socket, :edit, event_params) do
    case Events.update_event(socket.assigns.event, event_params) do
      {:ok, event} ->
        notify_parent({:saved, event})

        {:noreply,
         socket
         |> put_flash(:info, "Event updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_event(socket, :new, event_params) do
    case Events.create_event(event_params) do
      {:ok, event} ->
        notify_parent({:saved, event})

        {:noreply,
         socket
         |> put_flash(:info, "Event created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
