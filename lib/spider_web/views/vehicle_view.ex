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
      type: vehicle.type,
      status: vehicle.status,
      user_id: vehicle.user_id,
      business_id: vehicle.business_id,
      vroles: render_many(vehicle.vroles, VehicleView, "v_role.json", as: :v_role)
    }
  end

  def render("v_role.json", %{v_role: v_role}) do
    %{
      id: v_role.id,
      drole_id: v_role.drole_id,
      vehicle_id: v_role.vehicle_id,
      capacity: v_role.capacity,
    }
  end

end
