defmodule SpiderWeb.ExportZoneBundlerView do
  use SpiderWeb, :view
  alias SpiderWeb.ExportZoneBundlerView
  alias SpiderWeb.BusinessView
  alias SpiderWeb.DLivestockView

  alias SpiderWeb.ExportZoneLivestockOrderView

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
      export_zone_livestock_orders: render_many(export_zone_bundler.export_zone_livestock_orders, __MODULE__, "export_zone_livestock_order.json", as: :export_zone_livestock_order),
      business: render_one(export_zone_bundler.business, BusinessView, "business.json", as: :business) 
      |> Map.drop([
          :business_pin, 
          :registration_number
        ]
      )
    }
  end

  def render("export_zone_livestock_order.json", %{export_zone_livestock_order: export_zone_livestock_order}) do
    %{
      id: export_zone_livestock_order.id,
      dates: export_zone_livestock_order.dates,
      status: export_zone_livestock_order.status,
      export_zone_bundler_id: export_zone_livestock_order.export_zone_bundler_id,
      livestock_order_stage_id: export_zone_livestock_order.livestock_order_stage_id,
      livestock_order_id: export_zone_livestock_order.livestock_order_id,
      livestock_order: render_one(export_zone_livestock_order.livestock_order, __MODULE__, "livestock_order.json", as: :livestock_order)
    }
  end

  def render("livestock_order.json", %{livestock_order: livestock_order}) do
    %{
      id: livestock_order.id,
      price: livestock_order.price,
      total_cost: livestock_order.total_cost,
      quantity: livestock_order.quantity,
      d_livestock_id: livestock_order.d_livestock_id,
      d_livestock: render_one(livestock_order.d_livestock, DLivestockView, "d_livestock.json", as: :d_livestock)
    }
  end

end
