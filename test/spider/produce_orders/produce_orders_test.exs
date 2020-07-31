defmodule Spider.ProduceOrdersTest do
  use Spider.DataCase

  alias Spider.ProduceOrders

  describe "produce_orders" do
    alias Spider.ProduceOrders.ProduceOrder

    @valid_attrs %{price_per_unit: "some price_per_unit", quantity: 42, total_cost: 42}
    @update_attrs %{price_per_unit: "some updated price_per_unit", quantity: 43, total_cost: 43}
    @invalid_attrs %{price_per_unit: nil, quantity: nil, total_cost: nil}

    def produce_order_fixture(attrs \\ %{}) do
      {:ok, produce_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProduceOrders.create_produce_order()

      produce_order
    end

    test "list_produce_orders/0 returns all produce_orders" do
      produce_order = produce_order_fixture()
      assert ProduceOrders.list_produce_orders() == [produce_order]
    end

    test "get_produce_order!/1 returns the produce_order with given id" do
      produce_order = produce_order_fixture()
      assert ProduceOrders.get_produce_order!(produce_order.id) == produce_order
    end

    test "create_produce_order/1 with valid data creates a produce_order" do
      assert {:ok, %ProduceOrder{} = produce_order} = ProduceOrders.create_produce_order(@valid_attrs)
      assert produce_order.price_per_unit == "some price_per_unit"
      assert produce_order.quantity == 42
      assert produce_order.total_cost == 42
    end

    test "create_produce_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProduceOrders.create_produce_order(@invalid_attrs)
    end

    test "update_produce_order/2 with valid data updates the produce_order" do
      produce_order = produce_order_fixture()
      assert {:ok, produce_order} = ProduceOrders.update_produce_order(produce_order, @update_attrs)
      assert %ProduceOrder{} = produce_order
      assert produce_order.price_per_unit == "some updated price_per_unit"
      assert produce_order.quantity == 43
      assert produce_order.total_cost == 43
    end

    test "update_produce_order/2 with invalid data returns error changeset" do
      produce_order = produce_order_fixture()
      assert {:error, %Ecto.Changeset{}} = ProduceOrders.update_produce_order(produce_order, @invalid_attrs)
      assert produce_order == ProduceOrders.get_produce_order!(produce_order.id)
    end

    test "delete_produce_order/1 deletes the produce_order" do
      produce_order = produce_order_fixture()
      assert {:ok, %ProduceOrder{}} = ProduceOrders.delete_produce_order(produce_order)
      assert_raise Ecto.NoResultsError, fn -> ProduceOrders.get_produce_order!(produce_order.id) end
    end

    test "change_produce_order/1 returns a produce_order changeset" do
      produce_order = produce_order_fixture()
      assert %Ecto.Changeset{} = ProduceOrders.change_produce_order(produce_order)
    end
  end
end
