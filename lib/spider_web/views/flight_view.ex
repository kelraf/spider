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
      role: flight.role,
      user_id: flight.user_id,
      business_id: flight.business_id
    }
  end
end
