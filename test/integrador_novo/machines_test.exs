defmodule IntegradorNovo.MachinesTest do
  use IntegradorNovo.DataCase

  alias IntegradorNovo.Machines

  describe "machines" do
    alias IntegradorNovo.Machines.Machine

    import IntegradorNovo.MachinesFixtures

    @invalid_attrs %{description: nil}

    test "list_machines/0 returns all machines" do
      machine = machine_fixture()
      assert Machines.list_machines() == [machine]
    end

    test "get_machine!/1 returns the machine with given id" do
      machine = machine_fixture()
      assert Machines.get_machine!(machine.id) == machine
    end

    test "create_machine/1 with valid data creates a machine" do
      valid_attrs = %{description: "some description"}

      assert {:ok, %Machine{} = machine} = Machines.create_machine(valid_attrs)
      assert machine.description == "some description"
    end

    test "create_machine/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Machines.create_machine(@invalid_attrs)
    end

    test "update_machine/2 with valid data updates the machine" do
      machine = machine_fixture()
      update_attrs = %{description: "some updated description"}

      assert {:ok, %Machine{} = machine} = Machines.update_machine(machine, update_attrs)
      assert machine.description == "some updated description"
    end

    test "update_machine/2 with invalid data returns error changeset" do
      machine = machine_fixture()
      assert {:error, %Ecto.Changeset{}} = Machines.update_machine(machine, @invalid_attrs)
      assert machine == Machines.get_machine!(machine.id)
    end

    test "delete_machine/1 deletes the machine" do
      machine = machine_fixture()
      assert {:ok, %Machine{}} = Machines.delete_machine(machine)
      assert_raise Ecto.NoResultsError, fn -> Machines.get_machine!(machine.id) end
    end

    test "change_machine/1 returns a machine changeset" do
      machine = machine_fixture()
      assert %Ecto.Changeset{} = Machines.change_machine(machine)
    end
  end
end
