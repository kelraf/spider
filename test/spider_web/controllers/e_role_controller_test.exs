defmodule SpiderWeb.ERoleControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.ERoles
  alias Spider.ERoles.ERole

  @create_attrs %{capacity: 42}
  @update_attrs %{capacity: 43}
  @invalid_attrs %{capacity: nil}

  def fixture(:e_role) do
    {:ok, e_role} = ERoles.create_e_role(@create_attrs)
    e_role
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all eroles", %{conn: conn} do
      conn = get conn, e_role_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create e_role" do
    test "renders e_role when data is valid", %{conn: conn} do
      conn = post conn, e_role_path(conn, :create), e_role: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, e_role_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "capacity" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, e_role_path(conn, :create), e_role: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update e_role" do
    setup [:create_e_role]

    test "renders e_role when data is valid", %{conn: conn, e_role: %ERole{id: id} = e_role} do
      conn = put conn, e_role_path(conn, :update, e_role), e_role: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, e_role_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "capacity" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, e_role: e_role} do
      conn = put conn, e_role_path(conn, :update, e_role), e_role: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete e_role" do
    setup [:create_e_role]

    test "deletes chosen e_role", %{conn: conn, e_role: e_role} do
      conn = delete conn, e_role_path(conn, :delete, e_role)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, e_role_path(conn, :show, e_role)
      end
    end
  end

  defp create_e_role(_) do
    e_role = fixture(:e_role)
    {:ok, e_role: e_role}
  end
end
