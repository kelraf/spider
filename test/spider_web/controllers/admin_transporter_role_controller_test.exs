defmodule SpiderWeb.AdminTransporterRoleControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.AdminTransporterRoles
  alias Spider.AdminTransporterRoles.AdminTransporterRole

  @create_attrs %{role: "some role"}
  @update_attrs %{role: "some updated role"}
  @invalid_attrs %{role: nil}

  def fixture(:admin_transporter_role) do
    {:ok, admin_transporter_role} = AdminTransporterRoles.create_admin_transporter_role(@create_attrs)
    admin_transporter_role
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all admintransporterroles", %{conn: conn} do
      conn = get conn, admin_transporter_role_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create admin_transporter_role" do
    test "renders admin_transporter_role when data is valid", %{conn: conn} do
      conn = post conn, admin_transporter_role_path(conn, :create), admin_transporter_role: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, admin_transporter_role_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "role" => "some role"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, admin_transporter_role_path(conn, :create), admin_transporter_role: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update admin_transporter_role" do
    setup [:create_admin_transporter_role]

    test "renders admin_transporter_role when data is valid", %{conn: conn, admin_transporter_role: %AdminTransporterRole{id: id} = admin_transporter_role} do
      conn = put conn, admin_transporter_role_path(conn, :update, admin_transporter_role), admin_transporter_role: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, admin_transporter_role_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "role" => "some updated role"}
    end

    test "renders errors when data is invalid", %{conn: conn, admin_transporter_role: admin_transporter_role} do
      conn = put conn, admin_transporter_role_path(conn, :update, admin_transporter_role), admin_transporter_role: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete admin_transporter_role" do
    setup [:create_admin_transporter_role]

    test "deletes chosen admin_transporter_role", %{conn: conn, admin_transporter_role: admin_transporter_role} do
      conn = delete conn, admin_transporter_role_path(conn, :delete, admin_transporter_role)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, admin_transporter_role_path(conn, :show, admin_transporter_role)
      end
    end
  end

  defp create_admin_transporter_role(_) do
    admin_transporter_role = fixture(:admin_transporter_role)
    {:ok, admin_transporter_role: admin_transporter_role}
  end
end
