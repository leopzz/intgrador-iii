defmodule IntegradorNovoWeb.ConfigurationItemLive.Index do
  use IntegradorNovoWeb, :live_view

  alias IntegradorNovo.ConfigurationItems
  alias IntegradorNovo.ConfigurationItems.ConfigurationItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :configuration_item_collection, ConfigurationItems.list_configuration_item())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Configuration item")
    |> assign(:configuration_item, ConfigurationItems.get_configuration_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Configuration item")
    |> assign(:configuration_item, %ConfigurationItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Configuration item")
    |> assign(:configuration_item, nil)
  end

  @impl true
  def handle_info({IntegradorNovoWeb.ConfigurationItemLive.FormComponent, {:saved, configuration_item}}, socket) do
    {:noreply, stream_insert(socket, :configuration_item_collection, configuration_item)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    configuration_item = ConfigurationItems.get_configuration_item!(id)
    {:ok, _} = ConfigurationItems.delete_configuration_item(configuration_item)

    {:noreply, stream_delete(socket, :configuration_item_collection, configuration_item)}
  end
end
