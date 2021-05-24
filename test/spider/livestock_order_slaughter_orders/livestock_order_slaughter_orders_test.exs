defmodule Spider.LivestockOrderSlaughterOrdersTest do
  use Spider.DataCase

  alias Spider.LivestockOrderSlaughterOrders

  describe "livestock_order_slaughter_orders" do
    alias Spider.LivestockOrderSlaughterOrders.LivestockOrderSlaughterOrder

    @valid_attrs %{dates: "some dates", description: "some description", status: 42}
    @update_attrs %{dates: "some updated dates", description: "some updated description", status: 43}
    @invalid_attrs %{dates: nil, description: nil, status: nil}

    def livestock_order_slaughter_order_fixture(attrs \\ %{}) do
      {:ok, livestock_order_slaughter_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LivestockOrderSlaughterOrders.create_livestock_order_slaughter_order()

      livestock_order_slaughter_order
    end

    test "list_livestock_order_slaughter_orders/0 returns all livestock_order_slaughter_orders" do
      livestock_order_slaughter_order = livestock_order_slaughter_order_fixture()
      assert LivestockOrderSlaughterOrders.list_livestock_order_slaughter_orders() == [livestock_order_slaughter_order]
    end

    test "get_livestock_order_slaughter_order!/1 returns the livestock_order_slaughter_order with given id" do
      livestock_order_slaughter_order = livestock_order_slaughter_order_fixture()
      assert LivestockOrderSlaughterOrders.get_livestock_order_slaughter_order!(livestock_order_slaughter_order.id) == livestock_order_slaughter_order
    end

    test "create_livestock_order_slaughter_order/1 with valid data creates a livestock_order_slaughter_order" do
      assert {:ok, %LivestockOrderSlaughterOrder{} = livestock_order_slaughter_order} = LivestockOrderSlaughterOrders.create_livestock_order_slaughter_order(@valid_attrs)
      assert livestock_order_slaughter_order.dates == "some dates"
      assert livestock_order_slaughter_order.description == "some description"
      assert livestock_order_slaughter_order.status == 42
    end

    test "create_livestock_order_slaughter_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LivestockOrderSlaughterOrders.create_livestock_order_slaughter_order(@invalid_attrs)
    end

    test "update_livestock_order_slaughter_order/2 with valid data updates the livestock_order_slaughter_order" do
      livestock_order_slaughter_order = livestock_order_slaughter_order_fixture()
      assert {:ok, livestock_order_slaughter_order} = LivestockOrderSlaughterOrders.update_livestock_order_slaughter_order(livestock_order_slaughter_order, @update_attrs)
      assert %LivestockOrderSlaughterOrder{} = livestock_order_slaughter_order
      assert livestock_order_slaughter_order.dates == "some updated dates"
      assert livestock_order_slaughter_order.description == "some updated description"
      assert livestock_order_slaughter_order.status == 43
    end

    test "update_livestock_order_slaughter_order/2 with invalid data returns error changeset" do
      livestock_order_slaughter_order = livestock_order_slaughter_order_fixture()
      assert {:error, %Ecto.Changeset{}} = LivestockOrderSlaughterOrders.update_livestock_order_slaughter_order(livestock_order_slaughter_order, @invalid_attrs)
      assert livestock_order_slaughter_order == LivestockOrderSlaughterOrders.get_livestock_order_slaughter_order!(livestock_order_slaughter_order.id)
    end

    test "delete_livestock_order_slaughter_order/1 deletes the livestock_order_slaughter_order" do
      livestock_order_slaughter_order = livestock_order_slaughter_order_fixture()
      assert {:ok, %LivestockOrderSlaughterOrder{}} = LivestockOrderSlaughterOrders.delete_livestock_order_slaughter_order(livestock_order_slaughter_order)
      assert_raise Ecto.NoResultsError, fn -> LivestockOrderSlaughterOrders.get_livestock_order_slaughter_order!(livestock_order_slaughter_order.id) end
    end

    test "change_livestock_order_slaughter_order/1 returns a livestock_order_slaughter_order changeset" do
      livestock_order_slaughter_order = livestock_order_slaughter_order_fixture()
      assert %Ecto.Changeset{} = LivestockOrderSlaughterOrders.change_livestock_order_slaughter_order(livestock_order_slaughter_order)
    end
  end
end
