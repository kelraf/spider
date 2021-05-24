defmodule Spider.CCPPOrdersTest do
  use Spider.DataCase

  alias Spider.CCPPOrders

  describe "c_c_p_p_orders" do
    alias Spider.CCPPOrders.CCPPOrder

    @valid_attrs %{file: "some file", purpose: "some purpose"}
    @update_attrs %{file: "some updated file", purpose: "some updated purpose"}
    @invalid_attrs %{file: nil, purpose: nil}

    def ccpp_order_fixture(attrs \\ %{}) do
      {:ok, ccpp_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CCPPOrders.create_ccpp_order()

      ccpp_order
    end

    test "list_c_c_p_p_orders/0 returns all c_c_p_p_orders" do
      ccpp_order = ccpp_order_fixture()
      assert CCPPOrders.list_c_c_p_p_orders() == [ccpp_order]
    end

    test "get_ccpp_order!/1 returns the ccpp_order with given id" do
      ccpp_order = ccpp_order_fixture()
      assert CCPPOrders.get_ccpp_order!(ccpp_order.id) == ccpp_order
    end

    test "create_ccpp_order/1 with valid data creates a ccpp_order" do
      assert {:ok, %CCPPOrder{} = ccpp_order} = CCPPOrders.create_ccpp_order(@valid_attrs)
      assert ccpp_order.file == "some file"
      assert ccpp_order.purpose == "some purpose"
    end

    test "create_ccpp_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CCPPOrders.create_ccpp_order(@invalid_attrs)
    end

    test "update_ccpp_order/2 with valid data updates the ccpp_order" do
      ccpp_order = ccpp_order_fixture()
      assert {:ok, ccpp_order} = CCPPOrders.update_ccpp_order(ccpp_order, @update_attrs)
      assert %CCPPOrder{} = ccpp_order
      assert ccpp_order.file == "some updated file"
      assert ccpp_order.purpose == "some updated purpose"
    end

    test "update_ccpp_order/2 with invalid data returns error changeset" do
      ccpp_order = ccpp_order_fixture()
      assert {:error, %Ecto.Changeset{}} = CCPPOrders.update_ccpp_order(ccpp_order, @invalid_attrs)
      assert ccpp_order == CCPPOrders.get_ccpp_order!(ccpp_order.id)
    end

    test "delete_ccpp_order/1 deletes the ccpp_order" do
      ccpp_order = ccpp_order_fixture()
      assert {:ok, %CCPPOrder{}} = CCPPOrders.delete_ccpp_order(ccpp_order)
      assert_raise Ecto.NoResultsError, fn -> CCPPOrders.get_ccpp_order!(ccpp_order.id) end
    end

    test "change_ccpp_order/1 returns a ccpp_order changeset" do
      ccpp_order = ccpp_order_fixture()
      assert %Ecto.Changeset{} = CCPPOrders.change_ccpp_order(ccpp_order)
    end
  end
end
