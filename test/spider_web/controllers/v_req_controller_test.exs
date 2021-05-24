defmodule SpiderWeb.VReqControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.VReqs
  alias Spider.VReqs.VReq

  @create_attrs %{available: true}
  @update_attrs %{available: false}
  @invalid_attrs %{available: nil}

  def fixture(:v_req) do
    {:ok, v_req} = VReqs.create_v_req(@create_attrs)
    v_req
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all vreqs", %{conn: conn} do
      conn = get conn, v_req_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create v_req" do
    test "renders v_req when data is valid", %{conn: conn} do
      conn = post conn, v_req_path(conn, :create), v_req: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, v_req_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "available" => true}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, v_req_path(conn, :create), v_req: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update v_req" do
    setup [:create_v_req]

    test "renders v_req when data is valid", %{conn: conn, v_req: %VReq{id: id} = v_req} do
      conn = put conn, v_req_path(conn, :update, v_req), v_req: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, v_req_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "available" => false}
    end

    test "renders errors when data is invalid", %{conn: conn, v_req: v_req} do
      conn = put conn, v_req_path(conn, :update, v_req), v_req: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete v_req" do
    setup [:create_v_req]

    test "deletes chosen v_req", %{conn: conn, v_req: v_req} do
      conn = delete conn, v_req_path(conn, :delete, v_req)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, v_req_path(conn, :show, v_req)
      end
    end
  end

  defp create_v_req(_) do
    v_req = fixture(:v_req)
    {:ok, v_req: v_req}
  end
end
