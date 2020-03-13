defmodule SpiderWeb.VessleControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Vessles
  alias Spider.Vessles.Vessle

  @create_attrs %{role: "some role", unique_number: "some unique_number"}
  @update_attrs %{role: "some updated role", unique_number: "some updated unique_number"}
  @invalid_attrs %{role: nil, unique_number: nil}

  def fixture(:vessle) do
    {:ok, vessle} = Vessles.create_vessle(@create_attrs)
    vessle
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all vessles", %{conn: conn} do
      conn = get conn, vessle_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create vessle" do
    test "renders vessle when data is valid", %{conn: conn} do
      conn = post conn, vessle_path(conn, :create), vessle: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, vessle_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "role" => "some role",
        "unique_number" => "some unique_number"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, vessle_path(conn, :create), vessle: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update vessle" do
    setup [:create_vessle]

    test "renders vessle when data is valid", %{conn: conn, vessle: %Vessle{id: id} = vessle} do
      conn = put conn, vessle_path(conn, :update, vessle), vessle: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, vessle_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "role" => "some updated role",
        "unique_number" => "some updated unique_number"}
    end

    test "renders errors when data is invalid", %{conn: conn, vessle: vessle} do
      conn = put conn, vessle_path(conn, :update, vessle), vessle: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete vessle" do
    setup [:create_vessle]

    test "deletes chosen vessle", %{conn: conn, vessle: vessle} do
      conn = delete conn, vessle_path(conn, :delete, vessle)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, vessle_path(conn, :show, vessle)
      end
    end
  end

  defp create_vessle(_) do
    vessle = fixture(:vessle)
    {:ok, vessle: vessle}
  end
end
