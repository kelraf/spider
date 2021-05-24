defmodule SpiderWeb.TransporterRoleControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.TransporterRoles
  alias Spider.TransporterRoles.TransporterRole

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:transporter_role) do
    {:ok, transporter_role} = TransporterRoles.create_transporter_role(@create_attrs)
    transporter_role
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transporterroles", %{conn: conn} do
      conn = get conn, transporter_role_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transporter_role" do
    test "renders transporter_role when data is valid", %{conn: conn} do
      conn = post conn, transporter_role_path(conn, :create), transporter_role: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, transporter_role_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, transporter_role_path(conn, :create), transporter_role: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transporter_role" do
    setup [:create_transporter_role]

    test "renders transporter_role when data is valid", %{conn: conn, transporter_role: %TransporterRole{id: id} = transporter_role} do
      conn = put conn, transporter_role_path(conn, :update, transporter_role), transporter_role: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, transporter_role_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, transporter_role: transporter_role} do
      conn = put conn, transporter_role_path(conn, :update, transporter_role), transporter_role: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transporter_role" do
    setup [:create_transporter_role]

    test "deletes chosen transporter_role", %{conn: conn, transporter_role: transporter_role} do
      conn = delete conn, transporter_role_path(conn, :delete, transporter_role)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, transporter_role_path(conn, :show, transporter_role)
      end
    end
  end

  defp create_transporter_role(_) do
    transporter_role = fixture(:transporter_role)
    {:ok, transporter_role: transporter_role}
  end
end
