defmodule IntegradorNovoWeb.ConfigurationItemLive.FormComponent do
  use IntegradorNovoWeb, :live_component

  alias IntegradorNovo.ConfigurationItems

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage configuration_item records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="configuration_item-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:item_type]} type="select" label="Item Type" options={@item_types} />
        <:actions>
          <.button phx-disable-with="Saving...">Save Configuration item</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  @spec update(%{:configuration_item => any(), optional(any()) => any()}, any()) :: {:ok, map()}
  def update(%{configuration_item: configuration_item} = assigns, socket) do
    item_types = [
      {"RAM Usage", 1},
      {"CPU Usage", 2},
      {"Disk Usage", 3},
      {"Process Count", 4},
      {"Swap Usage", 5},
      {"Network IO", 6},
      {"CPU Frequency", 7}
    ]
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:item_types, item_types)
     |> assign_new(:form, fn ->
       to_form(ConfigurationItems.change_configuration_item(configuration_item))
     end)}
  end

  @impl true
  def handle_event("validate", %{"configuration_item" => configuration_item_params}, socket) do
    changeset = ConfigurationItems.change_configuration_item(socket.assigns.configuration_item, configuration_item_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"configuration_item" => configuration_item_params}, socket) do
    save_configuration_item(socket, socket.assigns.action, configuration_item_params)
  end

  defp save_configuration_item(socket, :edit, configuration_item_params) do
    case ConfigurationItems.update_configuration_item(socket.assigns.configuration_item, configuration_item_params) do
      {:ok, configuration_item} ->
        notify_parent({:saved, configuration_item})

        {:noreply,
         socket
         |> put_flash(:info, "Configuration item updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_configuration_item(socket, :new, configuration_item_params) do
    case ConfigurationItems.create_configuration_item(configuration_item_params) do
      {:ok, configuration_item} ->
        notify_parent({:saved, configuration_item})

        {:noreply,
         socket
         |> put_flash(:info, "Configuration item created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
