defmodule SpiderWeb.FlightControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Flights
  alias Spider.Flights.Flight

  @create_attrs %{role: "some role", unique_number: "some unique_number"}
  @update_attrs %{role: "some updated role", unique_number: "some updated unique_number"}
  @invalid_attrs %{role: nil, unique_number: nil}

  def fixture(:flight) do
    {:ok, flight} = Flights.create_flight(@create_attrs)
    flight
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all flightes", %{conn: conn} do
      conn = get conn, flight_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create flight" do
    test "renders flight when data is valid", %{conn: conn} do
      conn = post conn, flight_path(conn, :create), flight: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, flight_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "role" => "some role",
        "unique_number" => "some unique_number"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, flight_path(conn, :create), flight: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update flight" do
    setup [:create_flight]

    test "renders flight when data is valid", %{conn: conn, flight: %Flight{id: id} = flight} do
      conn = put conn, flight_path(conn, :update, flight), flight: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, flight_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "role" => "some updated role",
        "unique_number" => "some updated unique_number"}
    end

    test "renders errors when data is invalid", %{conn: conn, flight: flight} do
      conn = put conn, flight_path(conn, :update, flight), flight: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete flight" do
    setup [:create_flight]

    test "deletes chosen flight", %{conn: conn, flight: flight} do
      conn = delete conn, flight_path(conn, :delete, flight)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, flight_path(conn, :show, flight)
      end
    end
  end

  defp create_flight(_) do
    flight = fixture(:flight)
    {:ok, flight: flight}
  end
end
