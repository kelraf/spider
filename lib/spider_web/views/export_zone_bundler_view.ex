defmodule SpiderWeb.ExportZoneBundlerView do
  use SpiderWeb, :view
  alias SpiderWeb.ExportZoneBundlerView
  alias SpiderWeb.BusinessView

  def render("index.json", %{export_zone_bundler: export_zone_bundler}) do
    %{data: render_many(export_zone_bundler, ExportZoneBundlerView, "export_zone_bundler.json")}
  end

  def render("show.json", %{export_zone_bundler: export_zone_bundler}) do
    %{data: render_one(export_zone_bundler, ExportZoneBundlerView, "export_zone_bundler.json")}
  end

  def render("export_zone_bundler.json", %{export_zone_bundler: export_zone_bundler}) do
    %{
      id: export_zone_bundler.id,
      capacity: export_zone_bundler.capacity,
      size: export_zone_bundler.size,
      business_id: export_zone_bundler.business_id,
      business: render_one(export_zone_bundler.business, BusinessView, "business.json", as: :business) |> Map.drop([:business_pin, :registration_number])
    }
  end
end
