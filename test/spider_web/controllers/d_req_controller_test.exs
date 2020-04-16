defmodule SpiderWeb.DReqControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.DReqs
  alias Spider.DReqs.DReq

  @create_attrs %{requirement: "some requirement"}
  @update_attrs %{requirement: "some updated requirement"}
  @invalid_attrs %{requirement: nil}

  def fixture(:d_req) do
    {:ok, d_req} = DReqs.create_d_req(@create_attrs)
    d_req
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all dreqs", %{conn: conn} do
      conn = get conn, d_req_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create d_req" do
    test "renders d_req when data is valid", %{conn: conn} do
      conn = post conn, d_req_path(conn, :create), d_req: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, d_req_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "requirement" => "some requirement"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, d_req_path(conn, :create), d_req: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update d_req" do
    setup [:create_d_req]

    test "renders d_req when data is valid", %{conn: conn, d_req: %DReq{id: id} = d_req} do
      conn = put conn, d_req_path(conn, :update, d_req), d_req: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, d_req_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "requirement" => "some updated requirement"}
    end

    test "renders errors when data is invalid", %{conn: conn, d_req: d_req} do
      conn = put conn, d_req_path(conn, :update, d_req), d_req: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete d_req" do
    setup [:create_d_req]

    test "deletes chosen d_req", %{conn: conn, d_req: d_req} do
      conn = delete conn, d_req_path(conn, :delete, d_req)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, d_req_path(conn, :show, d_req)
      end
    end
  end

  defp create_d_req(_) do
    d_req = fixture(:d_req)
    {:ok, d_req: d_req}
  end
end
