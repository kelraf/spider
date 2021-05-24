defmodule Spider.LivestockOrderContainersTest do
  use Spider.DataCase

  alias Spider.LivestockOrderContainers

  describe "livestock_order_containers" do
    alias Spider.LivestockOrderContainers.LivestockOrderContainer

    @valid_attrs %{channel: "some channel", status: 42, total_cost: "some total_cost"}
    @update_attrs %{channel: "some updated channel", status: 43, total_cost: "some updated total_cost"}
    @invalid_attrs %{channel: nil, status: nil, total_cost: nil}

    def livestock_order_container_fixture(attrs \\ %{}) do
      {:ok, livestock_order_container} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LivestockOrderContainers.create_livestock_order_container()

      livestock_order_container
    end

    test "list_livestock_order_containers/0 returns all livestock_order_containers" do
      livestock_order_container = livestock_order_container_fixture()
      assert LivestockOrderContainers.list_livestock_order_containers() == [livestock_order_container]
    end

    test "get_livestock_order_container!/1 returns the livestock_order_container with given id" do
      livestock_order_container = livestock_order_container_fixture()
      assert LivestockOrderContainers.get_livestock_order_container!(livestock_order_container.id) == livestock_order_container
    end

    test "create_livestock_order_container/1 with valid data creates a livestock_order_container" do
      assert {:ok, %LivestockOrderContainer{} = livestock_order_container} = LivestockOrderContainers.create_livestock_order_container(@valid_attrs)
      assert livestock_order_container.channel == "some channel"
      assert livestock_order_container.status == 42
      assert livestock_order_container.total_cost == "some total_cost"
    end

    test "create_livestock_order_container/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LivestockOrderContainers.create_livestock_order_container(@invalid_attrs)
    end

    test "update_livestock_order_container/2 with valid data updates the livestock_order_container" do
      livestock_order_container = livestock_order_container_fixture()
      assert {:ok, livestock_order_container} = LivestockOrderContainers.update_livestock_order_container(livestock_order_container, @update_attrs)
      assert %LivestockOrderContainer{} = livestock_order_container
      assert livestock_order_container.channel == "some updated channel"
      assert livestock_order_container.status == 43
      assert livestock_order_container.total_cost == "some updated total_cost"
    end

    test "update_livestock_order_container/2 with invalid data returns error changeset" do
      livestock_order_container = livestock_order_container_fixture()
      assert {:error, %Ecto.Changeset{}} = LivestockOrderContainers.update_livestock_order_container(livestock_order_container, @invalid_attrs)
      assert livestock_order_container == LivestockOrderContainers.get_livestock_order_container!(livestock_order_container.id)
    end

    test "delete_livestock_order_container/1 deletes the livestock_order_container" do
      livestock_order_container = livestock_order_container_fixture()
      assert {:ok, %LivestockOrderContainer{}} = LivestockOrderContainers.delete_livestock_order_container(livestock_order_container)
      assert_raise Ecto.NoResultsError, fn -> LivestockOrderContainers.get_livestock_order_container!(livestock_order_container.id) end
    end

    test "change_livestock_order_container/1 returns a livestock_order_container changeset" do
      livestock_order_container = livestock_order_container_fixture()
      assert %Ecto.Changeset{} = LivestockOrderContainers.change_livestock_order_container(livestock_order_container)
    end
  end
end
