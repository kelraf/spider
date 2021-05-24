defmodule Spider.LivestockOrdersTest do
  use Spider.DataCase

  alias Spider.LivestockOrders

  describe "livestock_orders" do
    alias Spider.LivestockOrders.LivestockOrder

    @valid_attrs %{price: 42, quantity: 42, total_cost: 42}
    @update_attrs %{price: 43, quantity: 43, total_cost: 43}
    @invalid_attrs %{price: nil, quantity: nil, total_cost: nil}

    def livestock_order_fixture(attrs \\ %{}) do
      {:ok, livestock_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LivestockOrders.create_livestock_order()

      livestock_order
    end

    test "list_livestock_orders/0 returns all livestock_orders" do
      livestock_order = livestock_order_fixture()
      assert LivestockOrders.list_livestock_orders() == [livestock_order]
    end

    test "get_livestock_order!/1 returns the livestock_order with given id" do
      livestock_order = livestock_order_fixture()
      assert LivestockOrders.get_livestock_order!(livestock_order.id) == livestock_order
    end

    test "create_livestock_order/1 with valid data creates a livestock_order" do
      assert {:ok, %LivestockOrder{} = livestock_order} = LivestockOrders.create_livestock_order(@valid_attrs)
      assert livestock_order.price == 42
      assert livestock_order.quantity == 42
      assert livestock_order.total_cost == 42
    end

    test "create_livestock_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LivestockOrders.create_livestock_order(@invalid_attrs)
    end

    test "update_livestock_order/2 with valid data updates the livestock_order" do
      livestock_order = livestock_order_fixture()
      assert {:ok, livestock_order} = LivestockOrders.update_livestock_order(livestock_order, @update_attrs)
      assert %LivestockOrder{} = livestock_order
      assert livestock_order.price == 43
      assert livestock_order.quantity == 43
      assert livestock_order.total_cost == 43
    end

    test "update_livestock_order/2 with invalid data returns error changeset" do
      livestock_order = livestock_order_fixture()
      assert {:error, %Ecto.Changeset{}} = LivestockOrders.update_livestock_order(livestock_order, @invalid_attrs)
      assert livestock_order == LivestockOrders.get_livestock_order!(livestock_order.id)
    end

    test "delete_livestock_order/1 deletes the livestock_order" do
      livestock_order = livestock_order_fixture()
      assert {:ok, %LivestockOrder{}} = LivestockOrders.delete_livestock_order(livestock_order)
      assert_raise Ecto.NoResultsError, fn -> LivestockOrders.get_livestock_order!(livestock_order.id) end
    end

    test "change_livestock_order/1 returns a livestock_order changeset" do
      livestock_order = livestock_order_fixture()
      assert %Ecto.Changeset{} = LivestockOrders.change_livestock_order(livestock_order)
    end
  end
end
