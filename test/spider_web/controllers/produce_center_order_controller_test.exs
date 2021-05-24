defmodule SpiderWeb.ProduceCenterOrderControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.ProduceCenterOrders
  alias Spider.ProduceCenterOrders.ProduceCenterOrder

  @create_attrs %{available_quantity: 42, description: "some description", required_quantity: 42, status: "some status", total_cost: 42}
  @update_attrs %{available_quantity: 43, description: "some updated description", required_quantity: 43, status: "some updated status", total_cost: 43}
  @invalid_attrs %{available_quantity: nil, description: nil, required_quantity: nil, status: nil, total_cost: nil}

  def fixture(:produce_center_order) do
    {:ok, produce_center_order} = ProduceCenterOrders.create_produce_center_order(@create_attrs)
    produce_center_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all produce_center_orders", %{conn: conn} do
      conn = get conn, produce_center_order_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create produce_center_order" do
    test "renders produce_center_order when data is valid", %{conn: conn} do
      conn = post conn, produce_center_order_path(conn, :create), produce_center_order: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, produce_center_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "available_quantity" => 42,
        "description" => "some description",
        "required_quantity" => 42,
        "status" => "some status",
        "total_cost" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, produce_center_order_path(conn, :create), produce_center_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update produce_center_order" do
    setup [:create_produce_center_order]

    test "renders produce_center_order when data is valid", %{conn: conn, produce_center_order: %ProduceCenterOrder{id: id} = produce_center_order} do
      conn = put conn, produce_center_order_path(conn, :update, produce_center_order), produce_center_order: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, produce_center_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "available_quantity" => 43,
        "description" => "some updated description",
        "required_quantity" => 43,
        "status" => "some updated status",
        "total_cost" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, produce_center_order: produce_center_order} do
      conn = put conn, produce_center_order_path(conn, :update, produce_center_order), produce_center_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete produce_center_order" do
    setup [:create_produce_center_order]

    test "deletes chosen produce_center_order", %{conn: conn, produce_center_order: produce_center_order} do
      conn = delete conn, produce_center_order_path(conn, :delete, produce_center_order)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, produce_center_order_path(conn, :show, produce_center_order)
      end
    end
  end

  defp create_produce_center_order(_) do
    produce_center_order = fixture(:produce_center_order)
    {:ok, produce_center_order: produce_center_order}
  end
end
