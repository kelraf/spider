defmodule SpiderWeb.ExportZoneLivestockOrderControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.ExportZoneLivestockOrders
  alias Spider.ExportZoneLivestockOrders.ExportZoneLivestockOrder

  @create_attrs %{dates: "some dates"}
  @update_attrs %{dates: "some updated dates"}
  @invalid_attrs %{dates: nil}

  def fixture(:export_zone_livestock_order) do
    {:ok, export_zone_livestock_order} = ExportZoneLivestockOrders.create_export_zone_livestock_order(@create_attrs)
    export_zone_livestock_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all export_zone_livestock_orders", %{conn: conn} do
      conn = get conn, export_zone_livestock_order_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create export_zone_livestock_order" do
    test "renders export_zone_livestock_order when data is valid", %{conn: conn} do
      conn = post conn, export_zone_livestock_order_path(conn, :create), export_zone_livestock_order: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, export_zone_livestock_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "dates" => "some dates"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, export_zone_livestock_order_path(conn, :create), export_zone_livestock_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update export_zone_livestock_order" do
    setup [:create_export_zone_livestock_order]

    test "renders export_zone_livestock_order when data is valid", %{conn: conn, export_zone_livestock_order: %ExportZoneLivestockOrder{id: id} = export_zone_livestock_order} do
      conn = put conn, export_zone_livestock_order_path(conn, :update, export_zone_livestock_order), export_zone_livestock_order: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, export_zone_livestock_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "dates" => "some updated dates"}
    end

    test "renders errors when data is invalid", %{conn: conn, export_zone_livestock_order: export_zone_livestock_order} do
      conn = put conn, export_zone_livestock_order_path(conn, :update, export_zone_livestock_order), export_zone_livestock_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete export_zone_livestock_order" do
    setup [:create_export_zone_livestock_order]

    test "deletes chosen export_zone_livestock_order", %{conn: conn, export_zone_livestock_order: export_zone_livestock_order} do
      conn = delete conn, export_zone_livestock_order_path(conn, :delete, export_zone_livestock_order)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, export_zone_livestock_order_path(conn, :show, export_zone_livestock_order)
      end
    end
  end

  defp create_export_zone_livestock_order(_) do
    export_zone_livestock_order = fixture(:export_zone_livestock_order)
    {:ok, export_zone_livestock_order: export_zone_livestock_order}
  end
end
