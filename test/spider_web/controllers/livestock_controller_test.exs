defmodule SpiderWeb.LivestockControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Livestocks
  alias Spider.Livestocks.Livestock

  @create_attrs %{category: "some category", number: "some number", type: "some type"}
  @update_attrs %{category: "some updated category", number: "some updated number", type: "some updated type"}
  @invalid_attrs %{category: nil, number: nil, type: nil}

  def fixture(:livestock) do
    {:ok, livestock} = Livestocks.create_livestock(@create_attrs)
    livestock
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all livestocks", %{conn: conn} do
      conn = get conn, livestock_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create livestock" do
    test "renders livestock when data is valid", %{conn: conn} do
      conn = post conn, livestock_path(conn, :create), livestock: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, livestock_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "category" => "some category",
        "number" => "some number",
        "type" => "some type"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, livestock_path(conn, :create), livestock: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update livestock" do
    setup [:create_livestock]

    test "renders livestock when data is valid", %{conn: conn, livestock: %Livestock{id: id} = livestock} do
      conn = put conn, livestock_path(conn, :update, livestock), livestock: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, livestock_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "category" => "some updated category",
        "number" => "some updated number",
        "type" => "some updated type"}
    end

    test "renders errors when data is invalid", %{conn: conn, livestock: livestock} do
      conn = put conn, livestock_path(conn, :update, livestock), livestock: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete livestock" do
    setup [:create_livestock]

    test "deletes chosen livestock", %{conn: conn, livestock: livestock} do
      conn = delete conn, livestock_path(conn, :delete, livestock)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, livestock_path(conn, :show, livestock)
      end
    end
  end

  defp create_livestock(_) do
    livestock = fixture(:livestock)
    {:ok, livestock: livestock}
  end
end
