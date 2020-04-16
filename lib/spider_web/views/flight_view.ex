defmodule SpiderWeb.FlightView do
  use SpiderWeb, :view
  alias SpiderWeb.FlightView

  def render("index.json", %{flights: flights}) do
    %{data: render_many(flights, FlightView, "flight.json")} 
  end

  def render("show.json", %{flight: flight}) do
    %{data: render_one(flight, FlightView, "flight.json")}
  end

  def render("flight.json", %{flight: flight}) do
    %{
      id: flight.id,
      unique_number: flight.unique_number,
      type: flight.type,
      status: flight.status,
      user_id: flight.user_id,
      business_id: flight.business_id,
      froles: render_many(flight.froles, FlightView, "frole.json", as: :frole)
    }
  end

  def render("frole.json", %{frole: frole}) do
    %{
      id: frole.id,
      capacity: frole.capacity,
      flight_id: frole.flight_id,
      drole_id: frole.drole_id
    }
  end

end
