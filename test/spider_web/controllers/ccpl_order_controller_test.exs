defmodule SpiderWeb.CCPLOrderControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.CCPLOrders
  alias Spider.CCPLOrders.CCPLOrder

  @create_attrs %{purpose: "some purpose"}
  @update_attrs %{purpose: "some updated purpose"}
  @invalid_attrs %{purpose: nil}

  def fixture(:ccpl_order) do
    {:ok, ccpl_order} = CCPLOrders.create_ccpl_order(@create_attrs)
    ccpl_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all c_c_p_l_orders", %{conn: conn} do
      conn = get conn, ccpl_order_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create ccpl_order" do
    test "renders ccpl_order when data is valid", %{conn: conn} do
      conn = post conn, ccpl_order_path(conn, :create), ccpl_order: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, ccpl_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "purpose" => "some purpose"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, ccpl_order_path(conn, :create), ccpl_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update ccpl_order" do
    setup [:create_ccpl_order]

    test "renders ccpl_order when data is valid", %{conn: conn, ccpl_order: %CCPLOrder{id: id} = ccpl_order} do
      conn = put conn, ccpl_order_path(conn, :update, ccpl_order), ccpl_order: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, ccpl_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "purpose" => "some updated purpose"}
    end

    test "renders errors when data is invalid", %{conn: conn, ccpl_order: ccpl_order} do
      conn = put conn, ccpl_order_path(conn, :update, ccpl_order), ccpl_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete ccpl_order" do
    setup [:create_ccpl_order]

    test "deletes chosen ccpl_order", %{conn: conn, ccpl_order: ccpl_order} do
      conn = delete conn, ccpl_order_path(conn, :delete, ccpl_order)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, ccpl_order_path(conn, :show, ccpl_order)
      end
    end
  end

  defp create_ccpl_order(_) do
    ccpl_order = fixture(:ccpl_order)
    {:ok, ccpl_order: ccpl_order}
  end
end
