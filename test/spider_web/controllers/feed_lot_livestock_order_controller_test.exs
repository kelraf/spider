defmodule SpiderWeb.FeedLotLivestockOrderControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.FeedLotLivestockOrders
  alias Spider.FeedLotLivestockOrders.FeedLotLivestockOrder

  @create_attrs %{dates: "some dates", status: "some status"}
  @update_attrs %{dates: "some updated dates", status: "some updated status"}
  @invalid_attrs %{dates: nil, status: nil}

  def fixture(:feed_lot_livestock_order) do
    {:ok, feed_lot_livestock_order} = FeedLotLivestockOrders.create_feed_lot_livestock_order(@create_attrs)
    feed_lot_livestock_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all feed_lot_livestock_orders", %{conn: conn} do
      conn = get conn, feed_lot_livestock_order_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create feed_lot_livestock_order" do
    test "renders feed_lot_livestock_order when data is valid", %{conn: conn} do
      conn = post conn, feed_lot_livestock_order_path(conn, :create), feed_lot_livestock_order: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, feed_lot_livestock_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "dates" => "some dates",
        "status" => "some status"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, feed_lot_livestock_order_path(conn, :create), feed_lot_livestock_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update feed_lot_livestock_order" do
    setup [:create_feed_lot_livestock_order]

    test "renders feed_lot_livestock_order when data is valid", %{conn: conn, feed_lot_livestock_order: %FeedLotLivestockOrder{id: id} = feed_lot_livestock_order} do
      conn = put conn, feed_lot_livestock_order_path(conn, :update, feed_lot_livestock_order), feed_lot_livestock_order: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, feed_lot_livestock_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "dates" => "some updated dates",
        "status" => "some updated status"}
    end

    test "renders errors when data is invalid", %{conn: conn, feed_lot_livestock_order: feed_lot_livestock_order} do
      conn = put conn, feed_lot_livestock_order_path(conn, :update, feed_lot_livestock_order), feed_lot_livestock_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete feed_lot_livestock_order" do
    setup [:create_feed_lot_livestock_order]

    test "deletes chosen feed_lot_livestock_order", %{conn: conn, feed_lot_livestock_order: feed_lot_livestock_order} do
      conn = delete conn, feed_lot_livestock_order_path(conn, :delete, feed_lot_livestock_order)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, feed_lot_livestock_order_path(conn, :show, feed_lot_livestock_order)
      end
    end
  end

  defp create_feed_lot_livestock_order(_) do
    feed_lot_livestock_order = fixture(:feed_lot_livestock_order)
    {:ok, feed_lot_livestock_order: feed_lot_livestock_order}
  end
end
