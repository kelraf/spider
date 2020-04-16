defmodule SpiderWeb.DreqControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Dreqs
  alias Spider.Dreqs.Dreq

  @create_attrs %{requirement: "some requirement"}
  @update_attrs %{requirement: "some updated requirement"}
  @invalid_attrs %{requirement: nil}

  def fixture(:dreq) do
    {:ok, dreq} = Dreqs.create_dreq(@create_attrs)
    dreq
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all dreqs", %{conn: conn} do
      conn = get conn, dreq_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create dreq" do
    test "renders dreq when data is valid", %{conn: conn} do
      conn = post conn, dreq_path(conn, :create), dreq: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, dreq_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "requirement" => "some requirement"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, dreq_path(conn, :create), dreq: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update dreq" do
    setup [:create_dreq]

    test "renders dreq when data is valid", %{conn: conn, dreq: %Dreq{id: id} = dreq} do
      conn = put conn, dreq_path(conn, :update, dreq), dreq: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, dreq_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "requirement" => "some updated requirement"}
    end

    test "renders errors when data is invalid", %{conn: conn, dreq: dreq} do
      conn = put conn, dreq_path(conn, :update, dreq), dreq: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete dreq" do
    setup [:create_dreq]

    test "deletes chosen dreq", %{conn: conn, dreq: dreq} do
      conn = delete conn, dreq_path(conn, :delete, dreq)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, dreq_path(conn, :show, dreq)
      end
    end
  end

  defp create_dreq(_) do
    dreq = fixture(:dreq)
    {:ok, dreq: dreq}
  end
end
