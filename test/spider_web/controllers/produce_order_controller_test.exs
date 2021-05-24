defmodule SpiderWeb.ProduceOrderControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.ProduceOrders
  alias Spider.ProduceOrders.ProduceOrder

  @create_attrs %{price_per_unit: "some price_per_unit", quantity: 42, total_cost: 42}
  @update_attrs %{price_per_unit: "some updated price_per_unit", quantity: 43, total_cost: 43}
  @invalid_attrs %{price_per_unit: nil, quantity: nil, total_cost: nil}

  def fixture(:produce_order) do
    {:ok, produce_order} = ProduceOrders.create_produce_order(@create_attrs)
    produce_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all produce_orders", %{conn: conn} do
      conn = get conn, produce_order_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create produce_order" do
    test "renders produce_order when data is valid", %{conn: conn} do
      conn = post conn, produce_order_path(conn, :create), produce_order: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, produce_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "price_per_unit" => "some price_per_unit",
        "quantity" => 42,
        "total_cost" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, produce_order_path(conn, :create), produce_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update produce_order" do
    setup [:create_produce_order]

    test "renders produce_order when data is valid", %{conn: conn, produce_order: %ProduceOrder{id: id} = produce_order} do
      conn = put conn, produce_order_path(conn, :update, produce_order), produce_order: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, produce_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "price_per_unit" => "some updated price_per_unit",
        "quantity" => 43,
        "total_cost" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, produce_order: produce_order} do
      conn = put conn, produce_order_path(conn, :update, produce_order), produce_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete produce_order" do
    setup [:create_produce_order]

    test "deletes chosen produce_order", %{conn: conn, produce_order: produce_order} do
      conn = delete conn, produce_order_path(conn, :delete, produce_order)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, produce_order_path(conn, :show, produce_order)
      end
    end
  end

  defp create_produce_order(_) do
    produce_order = fixture(:produce_order)
    {:ok, produce_order: produce_order}
  end
end
