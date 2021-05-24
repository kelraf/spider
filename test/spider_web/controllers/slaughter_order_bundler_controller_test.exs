defmodule SpiderWeb.SlaughterOrderBundlerControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.SlaughterOrderBundlers
  alias Spider.SlaughterOrderBundlers.SlaughterOrderBundler

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:slaughter_order_bundler) do
    {:ok, slaughter_order_bundler} = SlaughterOrderBundlers.create_slaughter_order_bundler(@create_attrs)
    slaughter_order_bundler
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all slaughter_order_bundlers", %{conn: conn} do
      conn = get conn, slaughter_order_bundler_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create slaughter_order_bundler" do
    test "renders slaughter_order_bundler when data is valid", %{conn: conn} do
      conn = post conn, slaughter_order_bundler_path(conn, :create), slaughter_order_bundler: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, slaughter_order_bundler_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, slaughter_order_bundler_path(conn, :create), slaughter_order_bundler: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update slaughter_order_bundler" do
    setup [:create_slaughter_order_bundler]

    test "renders slaughter_order_bundler when data is valid", %{conn: conn, slaughter_order_bundler: %SlaughterOrderBundler{id: id} = slaughter_order_bundler} do
      conn = put conn, slaughter_order_bundler_path(conn, :update, slaughter_order_bundler), slaughter_order_bundler: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, slaughter_order_bundler_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, slaughter_order_bundler: slaughter_order_bundler} do
      conn = put conn, slaughter_order_bundler_path(conn, :update, slaughter_order_bundler), slaughter_order_bundler: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete slaughter_order_bundler" do
    setup [:create_slaughter_order_bundler]

    test "deletes chosen slaughter_order_bundler", %{conn: conn, slaughter_order_bundler: slaughter_order_bundler} do
      conn = delete conn, slaughter_order_bundler_path(conn, :delete, slaughter_order_bundler)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, slaughter_order_bundler_path(conn, :show, slaughter_order_bundler)
      end
    end
  end

  defp create_slaughter_order_bundler(_) do
    slaughter_order_bundler = fixture(:slaughter_order_bundler)
    {:ok, slaughter_order_bundler: slaughter_order_bundler}
  end
end
