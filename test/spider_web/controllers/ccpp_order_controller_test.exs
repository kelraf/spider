defmodule SpiderWeb.CCPPOrderControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.CCPPOrders
  alias Spider.CCPPOrders.CCPPOrder

  @create_attrs %{file: "some file", purpose: "some purpose"}
  @update_attrs %{file: "some updated file", purpose: "some updated purpose"}
  @invalid_attrs %{file: nil, purpose: nil}

  def fixture(:ccpp_order) do
    {:ok, ccpp_order} = CCPPOrders.create_ccpp_order(@create_attrs)
    ccpp_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all c_c_p_p_orders", %{conn: conn} do
      conn = get conn, ccpp_order_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create ccpp_order" do
    test "renders ccpp_order when data is valid", %{conn: conn} do
      conn = post conn, ccpp_order_path(conn, :create), ccpp_order: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, ccpp_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "file" => "some file",
        "purpose" => "some purpose"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, ccpp_order_path(conn, :create), ccpp_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update ccpp_order" do
    setup [:create_ccpp_order]

    test "renders ccpp_order when data is valid", %{conn: conn, ccpp_order: %CCPPOrder{id: id} = ccpp_order} do
      conn = put conn, ccpp_order_path(conn, :update, ccpp_order), ccpp_order: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, ccpp_order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "file" => "some updated file",
        "purpose" => "some updated purpose"}
    end

    test "renders errors when data is invalid", %{conn: conn, ccpp_order: ccpp_order} do
      conn = put conn, ccpp_order_path(conn, :update, ccpp_order), ccpp_order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete ccpp_order" do
    setup [:create_ccpp_order]

    test "deletes chosen ccpp_order", %{conn: conn, ccpp_order: ccpp_order} do
      conn = delete conn, ccpp_order_path(conn, :delete, ccpp_order)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, ccpp_order_path(conn, :show, ccpp_order)
      end
    end
  end

  defp create_ccpp_order(_) do
    ccpp_order = fixture(:ccpp_order)
    {:ok, ccpp_order: ccpp_order}
  end
end
