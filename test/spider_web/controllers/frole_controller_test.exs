defmodule SpiderWeb.FroleControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Froles
  alias Spider.Froles.Frole

  @create_attrs %{capacity: 42}
  @update_attrs %{capacity: 43}
  @invalid_attrs %{capacity: nil}

  def fixture(:frole) do
    {:ok, frole} = Froles.create_frole(@create_attrs)
    frole
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all froles", %{conn: conn} do
      conn = get conn, frole_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create frole" do
    test "renders frole when data is valid", %{conn: conn} do
      conn = post conn, frole_path(conn, :create), frole: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, frole_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "capacity" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, frole_path(conn, :create), frole: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update frole" do
    setup [:create_frole]

    test "renders frole when data is valid", %{conn: conn, frole: %Frole{id: id} = frole} do
      conn = put conn, frole_path(conn, :update, frole), frole: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, frole_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "capacity" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, frole: frole} do
      conn = put conn, frole_path(conn, :update, frole), frole: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete frole" do
    setup [:create_frole]

    test "deletes chosen frole", %{conn: conn, frole: frole} do
      conn = delete conn, frole_path(conn, :delete, frole)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, frole_path(conn, :show, frole)
      end
    end
  end

  defp create_frole(_) do
    frole = fixture(:frole)
    {:ok, frole: frole}
  end
end
