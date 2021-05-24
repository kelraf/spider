defmodule SpiderWeb.CenterOrderControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.CenterOrders
  alias Spider.CenterOrders.CenterOrder

  @create_attrs %{available: 42, price_per_animal: "some price_per_animal", required_animals: 42, status: "some status", total_price: "some total_price"}
  @update_attrs %{available: 43, price_per_animal: "some updated price_per_animal", required_animals: 43, status: "some updated status", total_price: "some updated total_price"}
  @invalid_attrs %{available: nil, price_per_animal: nil, required_animals: nil, status: nil, total_price: nil}

  def fixture(:center_order) do
    {:ok, center_order} = CenterOrders.create_center_order(@create_attrs)
    center_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all center_orders", %{conn: conn} do
      conn = get conn, center_order_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create center_order" do
    test "renders center_order when data is valid", %{conn: conn} do
      conn = post conn, center_order_path(conn, :create), center_order: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, center_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "available" => 42,
        "price_per_animal" => "some price_per_animal",
        "required_animals" => 42,
        "status" => "some status",
        "total_price" => "some total_price"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, center_order_path(conn, :create), center_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update center_order" do
    setup [:create_center_order]

    test "renders center_order when data is valid", %{conn: conn, center_order: %CenterOrder{id: id} = center_order} do
      conn = put conn, center_order_path(conn, :update, center_order), center_order: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, center_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "available" => 43,
        "price_per_animal" => "some updated price_per_animal",
        "required_animals" => 43,
        "status" => "some updated status",
        "total_price" => "some updated total_price"}
    end

    test "renders errors when data is invalid", %{conn: conn, center_order: center_order} do
      conn = put conn, center_order_path(conn, :update, center_order), center_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete center_order" do
    setup [:create_center_order]

    test "deletes chosen center_order", %{conn: conn, center_order: center_order} do
      conn = delete conn, center_order_path(conn, :delete, center_order)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, center_order_path(conn, :show, center_order)
      end
    end
  end

  defp create_center_order(_) do
    center_order = fixture(:center_order)
    {:ok, center_order: center_order}
  end
end
