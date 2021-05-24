defmodule SpiderWeb.DLivestockControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.DLivestocks
  alias Spider.DLivestocks.DLivestock

  @create_attrs %{breed: "some breed", category: "some category", reference: "some reference", type: "some type"}
  @update_attrs %{breed: "some updated breed", category: "some updated category", reference: "some updated reference", type: "some updated type"}
  @invalid_attrs %{breed: nil, category: nil, reference: nil, type: nil}

  def fixture(:d_livestock) do
    {:ok, d_livestock} = DLivestocks.create_d_livestock(@create_attrs)
    d_livestock
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all dlivestock", %{conn: conn} do
      conn = get conn, d_livestock_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create d_livestock" do
    test "renders d_livestock when data is valid", %{conn: conn} do
      conn = post conn, d_livestock_path(conn, :create), d_livestock: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, d_livestock_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "breed" => "some breed",
        "category" => "some category",
        "reference" => "some reference",
        "type" => "some type"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, d_livestock_path(conn, :create), d_livestock: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update d_livestock" do
    setup [:create_d_livestock]

    test "renders d_livestock when data is valid", %{conn: conn, d_livestock: %DLivestock{id: id} = d_livestock} do
      conn = put conn, d_livestock_path(conn, :update, d_livestock), d_livestock: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, d_livestock_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "breed" => "some updated breed",
        "category" => "some updated category",
        "reference" => "some updated reference",
        "type" => "some updated type"}
    end

    test "renders errors when data is invalid", %{conn: conn, d_livestock: d_livestock} do
      conn = put conn, d_livestock_path(conn, :update, d_livestock), d_livestock: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete d_livestock" do
    setup [:create_d_livestock]

    test "deletes chosen d_livestock", %{conn: conn, d_livestock: d_livestock} do
      conn = delete conn, d_livestock_path(conn, :delete, d_livestock)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, d_livestock_path(conn, :show, d_livestock)
      end
    end
  end

  defp create_d_livestock(_) do
    d_livestock = fixture(:d_livestock)
    {:ok, d_livestock: d_livestock}
  end
end
