defmodule SpiderWeb.VehicleControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Vehicles
  alias Spider.Vehicles.Vehicle

  @create_attrs %{registration_number: "some registration_number", role: "some role"}
  @update_attrs %{registration_number: "some updated registration_number", role: "some updated role"}
  @invalid_attrs %{registration_number: nil, role: nil}

  def fixture(:vehicle) do
    {:ok, vehicle} = Vehicles.create_vehicle(@create_attrs)
    vehicle
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all vehicles", %{conn: conn} do
      conn = get conn, vehicle_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create vehicle" do
    test "renders vehicle when data is valid", %{conn: conn} do
      conn = post conn, vehicle_path(conn, :create), vehicle: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, vehicle_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "registration_number" => "some registration_number",
        "role" => "some role"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, vehicle_path(conn, :create), vehicle: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update vehicle" do
    setup [:create_vehicle]

    test "renders vehicle when data is valid", %{conn: conn, vehicle: %Vehicle{id: id} = vehicle} do
      conn = put conn, vehicle_path(conn, :update, vehicle), vehicle: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, vehicle_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "registration_number" => "some updated registration_number",
        "role" => "some updated role"}
    end

    test "renders errors when data is invalid", %{conn: conn, vehicle: vehicle} do
      conn = put conn, vehicle_path(conn, :update, vehicle), vehicle: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete vehicle" do
    setup [:create_vehicle]

    test "deletes chosen vehicle", %{conn: conn, vehicle: vehicle} do
      conn = delete conn, vehicle_path(conn, :delete, vehicle)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, vehicle_path(conn, :show, vehicle)
      end
    end
  end

  defp create_vehicle(_) do
    vehicle = fixture(:vehicle)
    {:ok, vehicle: vehicle}
  end
end
