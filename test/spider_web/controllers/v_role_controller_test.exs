defmodule SpiderWeb.VRoleControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.VRoles
  alias Spider.VRoles.VRole

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:v_role) do
    {:ok, v_role} = VRoles.create_v_role(@create_attrs)
    v_role
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all vroles", %{conn: conn} do
      conn = get conn, v_role_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create v_role" do
    test "renders v_role when data is valid", %{conn: conn} do
      conn = post conn, v_role_path(conn, :create), v_role: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, v_role_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, v_role_path(conn, :create), v_role: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update v_role" do
    setup [:create_v_role]

    test "renders v_role when data is valid", %{conn: conn, v_role: %VRole{id: id} = v_role} do
      conn = put conn, v_role_path(conn, :update, v_role), v_role: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, v_role_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, v_role: v_role} do
      conn = put conn, v_role_path(conn, :update, v_role), v_role: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete v_role" do
    setup [:create_v_role]

    test "deletes chosen v_role", %{conn: conn, v_role: v_role} do
      conn = delete conn, v_role_path(conn, :delete, v_role)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, v_role_path(conn, :show, v_role)
      end
    end
  end

  defp create_v_role(_) do
    v_role = fixture(:v_role)
    {:ok, v_role: v_role}
  end
end
