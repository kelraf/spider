defmodule SpiderWeb.TransporterContainerControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.TransporterContainers
  alias Spider.TransporterContainers.TransporterContainer

  @create_attrs %{order_id: 42}
  @update_attrs %{order_id: 43}
  @invalid_attrs %{order_id: nil}

  def fixture(:transporter_container) do
    {:ok, transporter_container} = TransporterContainers.create_transporter_container(@create_attrs)
    transporter_container
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transportercontainer", %{conn: conn} do
      conn = get conn, transporter_container_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transporter_container" do
    test "renders transporter_container when data is valid", %{conn: conn} do
      conn = post conn, transporter_container_path(conn, :create), transporter_container: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, transporter_container_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "order_id" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, transporter_container_path(conn, :create), transporter_container: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transporter_container" do
    setup [:create_transporter_container]

    test "renders transporter_container when data is valid", %{conn: conn, transporter_container: %TransporterContainer{id: id} = transporter_container} do
      conn = put conn, transporter_container_path(conn, :update, transporter_container), transporter_container: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, transporter_container_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "order_id" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, transporter_container: transporter_container} do
      conn = put conn, transporter_container_path(conn, :update, transporter_container), transporter_container: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transporter_container" do
    setup [:create_transporter_container]

    test "deletes chosen transporter_container", %{conn: conn, transporter_container: transporter_container} do
      conn = delete conn, transporter_container_path(conn, :delete, transporter_container)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, transporter_container_path(conn, :show, transporter_container)
      end
    end
  end

  defp create_transporter_container(_) do
    transporter_container = fixture(:transporter_container)
    {:ok, transporter_container: transporter_container}
  end
end
