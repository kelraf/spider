defmodule Spider.ProduceCenterOrdersTest do
  use Spider.DataCase

  alias Spider.ProduceCenterOrders

  describe "produce_center_orders" do
    alias Spider.ProduceCenterOrders.ProduceCenterOrder

    @valid_attrs %{available_quantity: 42, description: "some description", required_quantity: 42, status: "some status", total_cost: 42}
    @update_attrs %{available_quantity: 43, description: "some updated description", required_quantity: 43, status: "some updated status", total_cost: 43}
    @invalid_attrs %{available_quantity: nil, description: nil, required_quantity: nil, status: nil, total_cost: nil}

    def produce_center_order_fixture(attrs \\ %{}) do
      {:ok, produce_center_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProduceCenterOrders.create_produce_center_order()

      produce_center_order
    end

    test "list_produce_center_orders/0 returns all produce_center_orders" do
      produce_center_order = produce_center_order_fixture()
      assert ProduceCenterOrders.list_produce_center_orders() == [produce_center_order]
    end

    test "get_produce_center_order!/1 returns the produce_center_order with given id" do
      produce_center_order = produce_center_order_fixture()
      assert ProduceCenterOrders.get_produce_center_order!(produce_center_order.id) == produce_center_order
    end

    test "create_produce_center_order/1 with valid data creates a produce_center_order" do
      assert {:ok, %ProduceCenterOrder{} = produce_center_order} = ProduceCenterOrders.create_produce_center_order(@valid_attrs)
      assert produce_center_order.available_quantity == 42
      assert produce_center_order.description == "some description"
      assert produce_center_order.required_quantity == 42
      assert produce_center_order.status == "some status"
      assert produce_center_order.total_cost == 42
    end

    test "create_produce_center_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProduceCenterOrders.create_produce_center_order(@invalid_attrs)
    end

    test "update_produce_center_order/2 with valid data updates the produce_center_order" do
      produce_center_order = produce_center_order_fixture()
      assert {:ok, produce_center_order} = ProduceCenterOrders.update_produce_center_order(produce_center_order, @update_attrs)
      assert %ProduceCenterOrder{} = produce_center_order
      assert produce_center_order.available_quantity == 43
      assert produce_center_order.description == "some updated description"
      assert produce_center_order.required_quantity == 43
      assert produce_center_order.status == "some updated status"
      assert produce_center_order.total_cost == 43
    end

    test "update_produce_center_order/2 with invalid data returns error changeset" do
      produce_center_order = produce_center_order_fixture()
      assert {:error, %Ecto.Changeset{}} = ProduceCenterOrders.update_produce_center_order(produce_center_order, @invalid_attrs)
      assert produce_center_order == ProduceCenterOrders.get_produce_center_order!(produce_center_order.id)
    end

    test "delete_produce_center_order/1 deletes the produce_center_order" do
      produce_center_order = produce_center_order_fixture()
      assert {:ok, %ProduceCenterOrder{}} = ProduceCenterOrders.delete_produce_center_order(produce_center_order)
      assert_raise Ecto.NoResultsError, fn -> ProduceCenterOrders.get_produce_center_order!(produce_center_order.id) end
    end

    test "change_produce_center_order/1 returns a produce_center_order changeset" do
      produce_center_order = produce_center_order_fixture()
      assert %Ecto.Changeset{} = ProduceCenterOrders.change_produce_center_order(produce_center_order)
    end
  end
end
