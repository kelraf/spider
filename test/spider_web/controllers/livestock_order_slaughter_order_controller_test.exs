defmodule SpiderWeb.LivestockOrderSlaughterOrderControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.LivestockOrderSlaughterOrders
  alias Spider.LivestockOrderSlaughterOrders.LivestockOrderSlaughterOrder

  @create_attrs %{dates: "some dates", description: "some description", status: 42}
  @update_attrs %{dates: "some updated dates", description: "some updated description", status: 43}
  @invalid_attrs %{dates: nil, description: nil, status: nil}

  def fixture(:livestock_order_slaughter_order) do
    {:ok, livestock_order_slaughter_order} = LivestockOrderSlaughterOrders.create_livestock_order_slaughter_order(@create_attrs)
    livestock_order_slaughter_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all livestock_order_slaughter_orders", %{conn: conn} do
      conn = get conn, livestock_order_slaughter_order_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create livestock_order_slaughter_order" do
    test "renders livestock_order_slaughter_order when data is valid", %{conn: conn} do
      conn = post conn, livestock_order_slaughter_order_path(conn, :create), livestock_order_slaughter_order: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, livestock_order_slaughter_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "dates" => "some dates",
        "description" => "some description",
        "status" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, livestock_order_slaughter_order_path(conn, :create), livestock_order_slaughter_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update livestock_order_slaughter_order" do
    setup [:create_livestock_order_slaughter_order]

    test "renders livestock_order_slaughter_order when data is valid", %{conn: conn, livestock_order_slaughter_order: %LivestockOrderSlaughterOrder{id: id} = livestock_order_slaughter_order} do
      conn = put conn, livestock_order_slaughter_order_path(conn, :update, livestock_order_slaughter_order), livestock_order_slaughter_order: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, livestock_order_slaughter_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "dates" => "some updated dates",
        "description" => "some updated description",
        "status" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, livestock_order_slaughter_order: livestock_order_slaughter_order} do
      conn = put conn, livestock_order_slaughter_order_path(conn, :update, livestock_order_slaughter_order), livestock_order_slaughter_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete livestock_order_slaughter_order" do
    setup [:create_livestock_order_slaughter_order]

    test "deletes chosen livestock_order_slaughter_order", %{conn: conn, livestock_order_slaughter_order: livestock_order_slaughter_order} do
      conn = delete conn, livestock_order_slaughter_order_path(conn, :delete, livestock_order_slaughter_order)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, livestock_order_slaughter_order_path(conn, :show, livestock_order_slaughter_order)
      end
    end
  end

  defp create_livestock_order_slaughter_order(_) do
    livestock_order_slaughter_order = fixture(:livestock_order_slaughter_order)
    {:ok, livestock_order_slaughter_order: livestock_order_slaughter_order}
  end
end
