defmodule SpiderWeb.TLivestockControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.TLivestocks
  alias Spider.TLivestocks.TLivestock

  @create_attrs %{quantity: 42}
  @update_attrs %{quantity: 43}
  @invalid_attrs %{quantity: nil}

  def fixture(:t_livestock) do
    {:ok, t_livestock} = TLivestocks.create_t_livestock(@create_attrs)
    t_livestock
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tlivestocks", %{conn: conn} do
      conn = get conn, t_livestock_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create t_livestock" do
    test "renders t_livestock when data is valid", %{conn: conn} do
      conn = post conn, t_livestock_path(conn, :create), t_livestock: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, t_livestock_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "quantity" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, t_livestock_path(conn, :create), t_livestock: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update t_livestock" do
    setup [:create_t_livestock]

    test "renders t_livestock when data is valid", %{conn: conn, t_livestock: %TLivestock{id: id} = t_livestock} do
      conn = put conn, t_livestock_path(conn, :update, t_livestock), t_livestock: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, t_livestock_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "quantity" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, t_livestock: t_livestock} do
      conn = put conn, t_livestock_path(conn, :update, t_livestock), t_livestock: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete t_livestock" do
    setup [:create_t_livestock]

    test "deletes chosen t_livestock", %{conn: conn, t_livestock: t_livestock} do
      conn = delete conn, t_livestock_path(conn, :delete, t_livestock)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, t_livestock_path(conn, :show, t_livestock)
      end
    end
  end

  defp create_t_livestock(_) do
    t_livestock = fixture(:t_livestock)
    {:ok, t_livestock: t_livestock}
  end
end
