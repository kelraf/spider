defmodule SpiderWeb.LivestockOrderControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.LivestockOrders
  alias Spider.LivestockOrders.LivestockOrder

  @create_attrs %{price: 42, quantity: 42, total_cost: 42}
  @update_attrs %{price: 43, quantity: 43, total_cost: 43}
  @invalid_attrs %{price: nil, quantity: nil, total_cost: nil}

  def fixture(:livestock_order) do
    {:ok, livestock_order} = LivestockOrders.create_livestock_order(@create_attrs)
    livestock_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all livestock_orders", %{conn: conn} do
      conn = get conn, livestock_order_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create livestock_order" do
    test "renders livestock_order when data is valid", %{conn: conn} do
      conn = post conn, livestock_order_path(conn, :create), livestock_order: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, livestock_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "price" => 42,
        "quantity" => 42,
        "total_cost" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, livestock_order_path(conn, :create), livestock_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update livestock_order" do
    setup [:create_livestock_order]

    test "renders livestock_order when data is valid", %{conn: conn, livestock_order: %LivestockOrder{id: id} = livestock_order} do
      conn = put conn, livestock_order_path(conn, :update, livestock_order), livestock_order: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, livestock_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "price" => 43,
        "quantity" => 43,
        "total_cost" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, livestock_order: livestock_order} do
      conn = put conn, livestock_order_path(conn, :update, livestock_order), livestock_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete livestock_order" do
    setup [:create_livestock_order]

    test "deletes chosen livestock_order", %{conn: conn, livestock_order: livestock_order} do
      conn = delete conn, livestock_order_path(conn, :delete, livestock_order)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, livestock_order_path(conn, :show, livestock_order)
      end
    end
  end

  defp create_livestock_order(_) do
    livestock_order = fixture(:livestock_order)
    {:ok, livestock_order: livestock_order}
  end
end
