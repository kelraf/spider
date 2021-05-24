defmodule SpiderWeb.TransporterControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Transporters
  alias Spider.Transporters.Transporter

  @create_attrs %{latitude_from: "some latitude_from", latitude_to: "some latitude_to", logitude_from: "some logitude_from", longitude_to: "some longitude_to", status: 42, transporter_id: 42}
  @update_attrs %{latitude_from: "some updated latitude_from", latitude_to: "some updated latitude_to", logitude_from: "some updated logitude_from", longitude_to: "some updated longitude_to", status: 43, transporter_id: 43}
  @invalid_attrs %{latitude_from: nil, latitude_to: nil, logitude_from: nil, longitude_to: nil, status: nil, transporter_id: nil}

  def fixture(:transporter) do
    {:ok, transporter} = Transporters.create_transporter(@create_attrs)
    transporter
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transporters", %{conn: conn} do
      conn = get conn, transporter_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transporter" do
    test "renders transporter when data is valid", %{conn: conn} do
      conn = post conn, transporter_path(conn, :create), transporter: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, transporter_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "latitude_from" => "some latitude_from",
        "latitude_to" => "some latitude_to",
        "logitude_from" => "some logitude_from",
        "longitude_to" => "some longitude_to",
        "status" => 42,
        "transporter_id" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, transporter_path(conn, :create), transporter: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transporter" do
    setup [:create_transporter]

    test "renders transporter when data is valid", %{conn: conn, transporter: %Transporter{id: id} = transporter} do
      conn = put conn, transporter_path(conn, :update, transporter), transporter: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, transporter_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "latitude_from" => "some updated latitude_from",
        "latitude_to" => "some updated latitude_to",
        "logitude_from" => "some updated logitude_from",
        "longitude_to" => "some updated longitude_to",
        "status" => 43,
        "transporter_id" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, transporter: transporter} do
      conn = put conn, transporter_path(conn, :update, transporter), transporter: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transporter" do
    setup [:create_transporter]

    test "deletes chosen transporter", %{conn: conn, transporter: transporter} do
      conn = delete conn, transporter_path(conn, :delete, transporter)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, transporter_path(conn, :show, transporter)
      end
    end
  end

  defp create_transporter(_) do
    transporter = fixture(:transporter)
    {:ok, transporter: transporter}
  end
end
