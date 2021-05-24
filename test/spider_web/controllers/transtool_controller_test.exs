defmodule SpiderWeb.TranstoolControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Transtools
  alias Spider.Transtools.Transtool

  @create_attrs %{brand: "some brand", model: "some model", registration_number: "some registration_number", type: "some type"}
  @update_attrs %{brand: "some updated brand", model: "some updated model", registration_number: "some updated registration_number", type: "some updated type"}
  @invalid_attrs %{brand: nil, model: nil, registration_number: nil, type: nil}

  def fixture(:transtool) do
    {:ok, transtool} = Transtools.create_transtool(@create_attrs)
    transtool
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transtools", %{conn: conn} do
      conn = get conn, transtool_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transtool" do
    test "renders transtool when data is valid", %{conn: conn} do
      conn = post conn, transtool_path(conn, :create), transtool: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, transtool_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "brand" => "some brand",
        "model" => "some model",
        "registration_number" => "some registration_number",
        "type" => "some type"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, transtool_path(conn, :create), transtool: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transtool" do
    setup [:create_transtool]

    test "renders transtool when data is valid", %{conn: conn, transtool: %Transtool{id: id} = transtool} do
      conn = put conn, transtool_path(conn, :update, transtool), transtool: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, transtool_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "brand" => "some updated brand",
        "model" => "some updated model",
        "registration_number" => "some updated registration_number",
        "type" => "some updated type"}
    end

    test "renders errors when data is invalid", %{conn: conn, transtool: transtool} do
      conn = put conn, transtool_path(conn, :update, transtool), transtool: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transtool" do
    setup [:create_transtool]

    test "deletes chosen transtool", %{conn: conn, transtool: transtool} do
      conn = delete conn, transtool_path(conn, :delete, transtool)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, transtool_path(conn, :show, transtool)
      end
    end
  end

  defp create_transtool(_) do
    transtool = fixture(:transtool)
    {:ok, transtool: transtool}
  end
end
