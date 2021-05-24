defmodule Spider.OrderContainersTest do
  use Spider.DataCase

  alias Spider.OrderContainers

  describe "ordercontainers" do
    alias Spider.OrderContainers.OrderContainer

    @valid_attrs %{business_id: 42, user_id: 42}
    @update_attrs %{business_id: 43, user_id: 43}
    @invalid_attrs %{business_id: nil, user_id: nil}

    def order_container_fixture(attrs \\ %{}) do
      {:ok, order_container} =
        attrs
        |> Enum.into(@valid_attrs)
        |> OrderContainers.create_order_container()

      order_container
    end

    test "list_ordercontainers/0 returns all ordercontainers" do
      order_container = order_container_fixture()
      assert OrderContainers.list_ordercontainers() == [order_container]
    end

    test "get_order_container!/1 returns the order_container with given id" do
      order_container = order_container_fixture()
      assert OrderContainers.get_order_container!(order_container.id) == order_container
    end

    test "create_order_container/1 with valid data creates a order_container" do
      assert {:ok, %OrderContainer{} = order_container} = OrderContainers.create_order_container(@valid_attrs)
      assert order_container.business_id == 42
      assert order_container.user_id == 42
    end

    test "create_order_container/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OrderContainers.create_order_container(@invalid_attrs)
    end

    test "update_order_container/2 with valid data updates the order_container" do
      order_container = order_container_fixture()
      assert {:ok, order_container} = OrderContainers.update_order_container(order_container, @update_attrs)
      assert %OrderContainer{} = order_container
      assert order_container.business_id == 43
      assert order_container.user_id == 43
    end

    test "update_order_container/2 with invalid data returns error changeset" do
      order_container = order_container_fixture()
      assert {:error, %Ecto.Changeset{}} = OrderContainers.update_order_container(order_container, @invalid_attrs)
      assert order_container == OrderContainers.get_order_container!(order_container.id)
    end

    test "delete_order_container/1 deletes the order_container" do
      order_container = order_container_fixture()
      assert {:ok, %OrderContainer{}} = OrderContainers.delete_order_container(order_container)
      assert_raise Ecto.NoResultsError, fn -> OrderContainers.get_order_container!(order_container.id) end
    end

    test "change_order_container/1 returns a order_container changeset" do
      order_container = order_container_fixture()
      assert %Ecto.Changeset{} = OrderContainers.change_order_container(order_container)
    end
  end
end
