defmodule Spider.CCPLOrdersTest do
  use Spider.DataCase

  alias Spider.CCPLOrders

  describe "c_c_p_l_orders" do
    alias Spider.CCPLOrders.CCPLOrder

    @valid_attrs %{purpose: "some purpose"}
    @update_attrs %{purpose: "some updated purpose"}
    @invalid_attrs %{purpose: nil}

    def ccpl_order_fixture(attrs \\ %{}) do
      {:ok, ccpl_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CCPLOrders.create_ccpl_order()

      ccpl_order
    end

    test "list_c_c_p_l_orders/0 returns all c_c_p_l_orders" do
      ccpl_order = ccpl_order_fixture()
      assert CCPLOrders.list_c_c_p_l_orders() == [ccpl_order]
    end

    test "get_ccpl_order!/1 returns the ccpl_order with given id" do
      ccpl_order = ccpl_order_fixture()
      assert CCPLOrders.get_ccpl_order!(ccpl_order.id) == ccpl_order
    end

    test "create_ccpl_order/1 with valid data creates a ccpl_order" do
      assert {:ok, %CCPLOrder{} = ccpl_order} = CCPLOrders.create_ccpl_order(@valid_attrs)
      assert ccpl_order.purpose == "some purpose"
    end

    test "create_ccpl_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CCPLOrders.create_ccpl_order(@invalid_attrs)
    end

    test "update_ccpl_order/2 with valid data updates the ccpl_order" do
      ccpl_order = ccpl_order_fixture()
      assert {:ok, ccpl_order} = CCPLOrders.update_ccpl_order(ccpl_order, @update_attrs)
      assert %CCPLOrder{} = ccpl_order
      assert ccpl_order.purpose == "some updated purpose"
    end

    test "update_ccpl_order/2 with invalid data returns error changeset" do
      ccpl_order = ccpl_order_fixture()
      assert {:error, %Ecto.Changeset{}} = CCPLOrders.update_ccpl_order(ccpl_order, @invalid_attrs)
      assert ccpl_order == CCPLOrders.get_ccpl_order!(ccpl_order.id)
    end

    test "delete_ccpl_order/1 deletes the ccpl_order" do
      ccpl_order = ccpl_order_fixture()
      assert {:ok, %CCPLOrder{}} = CCPLOrders.delete_ccpl_order(ccpl_order)
      assert_raise Ecto.NoResultsError, fn -> CCPLOrders.get_ccpl_order!(ccpl_order.id) end
    end

    test "change_ccpl_order/1 returns a ccpl_order changeset" do
      ccpl_order = ccpl_order_fixture()
      assert %Ecto.Changeset{} = CCPLOrders.change_ccpl_order(ccpl_order)
    end
  end
end
