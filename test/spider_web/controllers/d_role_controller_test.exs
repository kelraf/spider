defmodule SpiderWeb.DRoleControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.DRoles
  alias Spider.DRoles.DRole

  @create_attrs %{role: "some role"}
  @update_attrs %{role: "some updated role"}
  @invalid_attrs %{role: nil}

  def fixture(:d_role) do
    {:ok, d_role} = DRoles.create_d_role(@create_attrs)
    d_role
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all droles", %{conn: conn} do
      conn = get conn, d_role_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create d_role" do
    test "renders d_role when data is valid", %{conn: conn} do
      conn = post conn, d_role_path(conn, :create), d_role: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, d_role_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "role" => "some role"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, d_role_path(conn, :create), d_role: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update d_role" do
    setup [:create_d_role]

    test "renders d_role when data is valid", %{conn: conn, d_role: %DRole{id: id} = d_role} do
      conn = put conn, d_role_path(conn, :update, d_role), d_role: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, d_role_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "role" => "some updated role"}
    end

    test "renders errors when data is invalid", %{conn: conn, d_role: d_role} do
      conn = put conn, d_role_path(conn, :update, d_role), d_role: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete d_role" do
    setup [:create_d_role]

    test "deletes chosen d_role", %{conn: conn, d_role: d_role} do
      conn = delete conn, d_role_path(conn, :delete, d_role)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, d_role_path(conn, :show, d_role)
      end
    end
  end

  defp create_d_role(_) do
    d_role = fixture(:d_role)
    {:ok, d_role: d_role}
  end
end
