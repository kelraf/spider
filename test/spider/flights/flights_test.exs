defmodule Spider.FlightsTest do
  use Spider.DataCase

  alias Spider.Flights

  describe "flightes" do
    alias Spider.Flights.Flight

    @valid_attrs %{role: "some role", unique_number: "some unique_number"}
    @update_attrs %{role: "some updated role", unique_number: "some updated unique_number"}
    @invalid_attrs %{role: nil, unique_number: nil}

    def flight_fixture(attrs \\ %{}) do
      {:ok, flight} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Flights.create_flight()

      flight
    end

    test "list_flightes/0 returns all flightes" do
      flight = flight_fixture()
      assert Flights.list_flightes() == [flight]
    end

    test "get_flight!/1 returns the flight with given id" do
      flight = flight_fixture()
      assert Flights.get_flight!(flight.id) == flight
    end

    test "create_flight/1 with valid data creates a flight" do
      assert {:ok, %Flight{} = flight} = Flights.create_flight(@valid_attrs)
      assert flight.role == "some role"
      assert flight.unique_number == "some unique_number"
    end

    test "create_flight/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flights.create_flight(@invalid_attrs)
    end

    test "update_flight/2 with valid data updates the flight" do
      flight = flight_fixture()
      assert {:ok, flight} = Flights.update_flight(flight, @update_attrs)
      assert %Flight{} = flight
      assert flight.role == "some updated role"
      assert flight.unique_number == "some updated unique_number"
    end

    test "update_flight/2 with invalid data returns error changeset" do
      flight = flight_fixture()
      assert {:error, %Ecto.Changeset{}} = Flights.update_flight(flight, @invalid_attrs)
      assert flight == Flights.get_flight!(flight.id)
    end

    test "delete_flight/1 deletes the flight" do
      flight = flight_fixture()
      assert {:ok, %Flight{}} = Flights.delete_flight(flight)
      assert_raise Ecto.NoResultsError, fn -> Flights.get_flight!(flight.id) end
    end

    test "change_flight/1 returns a flight changeset" do
      flight = flight_fixture()
      assert %Ecto.Changeset{} = Flights.change_flight(flight)
    end
  end
end
