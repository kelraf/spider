defmodule Spider.TransporterContainersTest do
  use Spider.DataCase

  alias Spider.TransporterContainers

  describe "transportercontainer" do
    alias Spider.TransporterContainers.TransporterContainer

    @valid_attrs %{order_id: 42}
    @update_attrs %{order_id: 43}
    @invalid_attrs %{order_id: nil}

    def transporter_container_fixture(attrs \\ %{}) do
      {:ok, transporter_container} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TransporterContainers.create_transporter_container()

      transporter_container
    end

    test "list_transportercontainer/0 returns all transportercontainer" do
      transporter_container = transporter_container_fixture()
      assert TransporterContainers.list_transportercontainer() == [transporter_container]
    end

    test "get_transporter_container!/1 returns the transporter_container with given id" do
      transporter_container = transporter_container_fixture()
      assert TransporterContainers.get_transporter_container!(transporter_container.id) == transporter_container
    end

    test "create_transporter_container/1 with valid data creates a transporter_container" do
      assert {:ok, %TransporterContainer{} = transporter_container} = TransporterContainers.create_transporter_container(@valid_attrs)
      assert transporter_container.order_id == 42
    end

    test "create_transporter_container/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TransporterContainers.create_transporter_container(@invalid_attrs)
    end

    test "update_transporter_container/2 with valid data updates the transporter_container" do
      transporter_container = transporter_container_fixture()
      assert {:ok, transporter_container} = TransporterContainers.update_transporter_container(transporter_container, @update_attrs)
      assert %TransporterContainer{} = transporter_container
      assert transporter_container.order_id == 43
    end

    test "update_transporter_container/2 with invalid data returns error changeset" do
      transporter_container = transporter_container_fixture()
      assert {:error, %Ecto.Changeset{}} = TransporterContainers.update_transporter_container(transporter_container, @invalid_attrs)
      assert transporter_container == TransporterContainers.get_transporter_container!(transporter_container.id)
    end

    test "delete_transporter_container/1 deletes the transporter_container" do
      transporter_container = transporter_container_fixture()
      assert {:ok, %TransporterContainer{}} = TransporterContainers.delete_transporter_container(transporter_container)
      assert_raise Ecto.NoResultsError, fn -> TransporterContainers.get_transporter_container!(transporter_container.id) end
    end

    test "change_transporter_container/1 returns a transporter_container changeset" do
      transporter_container = transporter_container_fixture()
      assert %Ecto.Changeset{} = TransporterContainers.change_transporter_container(transporter_container)
    end
  end
end
