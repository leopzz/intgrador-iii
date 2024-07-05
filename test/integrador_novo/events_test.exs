defmodule IntegradorNovo.EventsTest do
  use IntegradorNovo.DataCase

  alias IntegradorNovo.Events

  describe "events" do
    alias IntegradorNovo.Events.Event

    import IntegradorNovo.EventsFixtures

    @invalid_attrs %{value: nil, description: nil, urgency: nil, impact: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{value: 120.5, description: "some description", urgency: 42, impact: 42}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.value == 120.5
      assert event.description == "some description"
      assert event.urgency == 42
      assert event.impact == 42
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{value: 456.7, description: "some updated description", urgency: 43, impact: 43}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.value == 456.7
      assert event.description == "some updated description"
      assert event.urgency == 43
      assert event.impact == 43
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
