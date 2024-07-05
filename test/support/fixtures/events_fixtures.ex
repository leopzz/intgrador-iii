defmodule IntegradorNovo.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IntegradorNovo.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        description: "some description",
        impact: 42,
        urgency: 42,
        value: 120.5
      })
      |> IntegradorNovo.Events.create_event()

    event
  end
end
