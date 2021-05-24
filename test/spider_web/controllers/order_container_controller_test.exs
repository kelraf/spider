defmodule SpiderWeb.OrderContainerControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.OrderContainers
  alias Spider.OrderContainers.OrderContainer

  @create_attrs %{business_id: 42, user_id: 42}
  @update_attrs %{business_id: 43, user_id: 43}
  @invalid_attrs %{business_id: nil, user_id: nil}

  def fixture(:order_container) do
    {:ok, order_container} = OrderContainers.create_order_container(@create_attrs)
    order_container
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all ordercontainers", %{conn: conn} do
      conn = get conn, order_container_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order_container" do
    test "renders order_container when data is valid", %{conn: conn} do
      conn = post conn, order_container_path(conn, :create), order_container: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, order_container_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "business_id" => 42,
        "user_id" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, order_container_path(conn, :create), order_container: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order_container" do
    setup [:create_order_container]

    test "renders order_container when data is valid", %{conn: conn, order_container: %OrderContainer{id: id} = order_container} do
      conn = put conn, order_container_path(conn, :update, order_container), order_container: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, order_container_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "business_id" => 43,
        "user_id" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, order_container: order_container} do
      conn = put conn, order_container_path(conn, :update, order_container), order_container: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete order_container" do
    setup [:create_order_container]

    test "deletes chosen order_container", %{conn: conn, order_container: order_container} do
      conn = delete conn, order_container_path(conn, :delete, order_container)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, order_container_path(conn, :show, order_container)
      end
    end
  end

  defp create_order_container(_) do
    order_container = fixture(:order_container)
    {:ok, order_container: order_container}
  end
end
