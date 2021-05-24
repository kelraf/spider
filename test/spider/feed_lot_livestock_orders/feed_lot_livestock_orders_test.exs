defmodule Spider.FeedLotLivestockOrdersTest do
  use Spider.DataCase

  alias Spider.FeedLotLivestockOrders

  describe "feed_lot_livestock_orders" do
    alias Spider.FeedLotLivestockOrders.FeedLotLivestockOrder

    @valid_attrs %{dates: "some dates", status: "some status"}
    @update_attrs %{dates: "some updated dates", status: "some updated status"}
    @invalid_attrs %{dates: nil, status: nil}

    def feed_lot_livestock_order_fixture(attrs \\ %{}) do
      {:ok, feed_lot_livestock_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FeedLotLivestockOrders.create_feed_lot_livestock_order()

      feed_lot_livestock_order
    end

    test "list_feed_lot_livestock_orders/0 returns all feed_lot_livestock_orders" do
      feed_lot_livestock_order = feed_lot_livestock_order_fixture()
      assert FeedLotLivestockOrders.list_feed_lot_livestock_orders() == [feed_lot_livestock_order]
    end

    test "get_feed_lot_livestock_order!/1 returns the feed_lot_livestock_order with given id" do
      feed_lot_livestock_order = feed_lot_livestock_order_fixture()
      assert FeedLotLivestockOrders.get_feed_lot_livestock_order!(feed_lot_livestock_order.id) == feed_lot_livestock_order
    end

    test "create_feed_lot_livestock_order/1 with valid data creates a feed_lot_livestock_order" do
      assert {:ok, %FeedLotLivestockOrder{} = feed_lot_livestock_order} = FeedLotLivestockOrders.create_feed_lot_livestock_order(@valid_attrs)
      assert feed_lot_livestock_order.dates == "some dates"
      assert feed_lot_livestock_order.status == "some status"
    end

    test "create_feed_lot_livestock_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FeedLotLivestockOrders.create_feed_lot_livestock_order(@invalid_attrs)
    end

    test "update_feed_lot_livestock_order/2 with valid data updates the feed_lot_livestock_order" do
      feed_lot_livestock_order = feed_lot_livestock_order_fixture()
      assert {:ok, feed_lot_livestock_order} = FeedLotLivestockOrders.update_feed_lot_livestock_order(feed_lot_livestock_order, @update_attrs)
      assert %FeedLotLivestockOrder{} = feed_lot_livestock_order
      assert feed_lot_livestock_order.dates == "some updated dates"
      assert feed_lot_livestock_order.status == "some updated status"
    end

    test "update_feed_lot_livestock_order/2 with invalid data returns error changeset" do
      feed_lot_livestock_order = feed_lot_livestock_order_fixture()
      assert {:error, %Ecto.Changeset{}} = FeedLotLivestockOrders.update_feed_lot_livestock_order(feed_lot_livestock_order, @invalid_attrs)
      assert feed_lot_livestock_order == FeedLotLivestockOrders.get_feed_lot_livestock_order!(feed_lot_livestock_order.id)
    end

    test "delete_feed_lot_livestock_order/1 deletes the feed_lot_livestock_order" do
      feed_lot_livestock_order = feed_lot_livestock_order_fixture()
      assert {:ok, %FeedLotLivestockOrder{}} = FeedLotLivestockOrders.delete_feed_lot_livestock_order(feed_lot_livestock_order)
      assert_raise Ecto.NoResultsError, fn -> FeedLotLivestockOrders.get_feed_lot_livestock_order!(feed_lot_livestock_order.id) end
    end

    test "change_feed_lot_livestock_order/1 returns a feed_lot_livestock_order changeset" do
      feed_lot_livestock_order = feed_lot_livestock_order_fixture()
      assert %Ecto.Changeset{} = FeedLotLivestockOrders.change_feed_lot_livestock_order(feed_lot_livestock_order)
    end
  end
end
