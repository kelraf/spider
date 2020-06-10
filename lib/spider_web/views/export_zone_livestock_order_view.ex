defmodule SpiderWeb.ExportZoneLivestockOrderView do
  use SpiderWeb, :view
  alias SpiderWeb.ExportZoneLivestockOrderView
  alias SpiderWeb.ExportZoneBundlerView

  def render("index.json", %{export_zone_livestock_orders: export_zone_livestock_orders}) do
    %{data: render_many(export_zone_livestock_orders, ExportZoneLivestockOrderView, "export_zone_livestock_order.json")}
  end

  def render("show.json", %{export_zone_livestock_order: export_zone_livestock_order}) do
    %{data: render_one(export_zone_livestock_order, ExportZoneLivestockOrderView, "export_zone_livestock_order.json")}
  end

  def render("export_zone_livestock_order.json", %{export_zone_livestock_order: export_zone_livestock_order}) do
    %{
      id: export_zone_livestock_order.id,
      dates: export_zone_livestock_order.dates,
      export_zone_bundler_id: export_zone_livestock_order.export_zone_bundler_id,
      livestock_order_stage_id: export_zone_livestock_order.livestock_order_stage_id,
      livestock_order_id: export_zone_livestock_order.livestock_order_id,
      export_zone_bundler: render_one(export_zone_livestock_order.export_zone_bundler, ExportZoneBundlerView, "export_zone_bundler.json", as: :export_zone_bundler)
    }
  end
end
