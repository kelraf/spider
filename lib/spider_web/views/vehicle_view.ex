defmodule SpiderWeb.VehicleView do
  use SpiderWeb, :view
  alias SpiderWeb.VehicleView

  def render("index.json", %{vehicles: vehicles}) do
    %{data: render_many(vehicles, VehicleView, "vehicle.json")}
  end

  def render("show.json", %{vehicle: vehicle}) do
    %{data: render_one(vehicle, VehicleView, "vehicle.json")}
  end

  def render("vehicle.json", %{vehicle: vehicle}) do
    %{
      id: vehicle.id,
      registration_number: vehicle.registration_number,
      role: vehicle.role,
      user_id: vehicle.user_id,
      business_id: vehicle.business_id
    }
  end
end
