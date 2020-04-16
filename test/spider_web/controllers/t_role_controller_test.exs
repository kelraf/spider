defmodule SpiderWeb.TRoleControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.TRoles
  alias Spider.TRoles.TRole

  @create_attrs %{capacity: 42}
  @update_attrs %{capacity: 43}
  @invalid_attrs %{capacity: nil}

  def fixture(:t_role) do
    {:ok, t_role} = TRoles.create_t_role(@create_attrs)
    t_role
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all troles", %{conn: conn} do
      conn = get conn, t_role_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create t_role" do
    test "renders t_role when data is valid", %{conn: conn} do
      conn = post conn, t_role_path(conn, :create), t_role: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, t_role_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "capacity" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, t_role_path(conn, :create), t_role: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update t_role" do
    setup [:create_t_role]

    test "renders t_role when data is valid", %{conn: conn, t_role: %TRole{id: id} = t_role} do
      conn = put conn, t_role_path(conn, :update, t_role), t_role: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, t_role_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "capacity" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, t_role: t_role} do
      conn = put conn, t_role_path(conn, :update, t_role), t_role: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete t_role" do
    setup [:create_t_role]

    test "deletes chosen t_role", %{conn: conn, t_role: t_role} do
      conn = delete conn, t_role_path(conn, :delete, t_role)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, t_role_path(conn, :show, t_role)
      end
    end
  end

  defp create_t_role(_) do
    t_role = fixture(:t_role)
    {:ok, t_role: t_role}
  end
end
