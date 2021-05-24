defmodule SpiderWeb.LivestockOrderSlaughterOrderView do 
  use SpiderWeb, :view
  alias SpiderWeb.LivestockOrderSlaughterOrderView
  alias SpiderWeb.LivestockOrderSlaughterOrderOutputView
  alias SpiderWeb.BusinessView
  alias SpiderWeb.DLivestockView

  def render("index.json", %{livestock_order_slaughter_orders: livestock_order_slaughter_orders}) do
    %{data: render_many(livestock_order_slaughter_orders, LivestockOrderSlaughterOrderView, "livestock_order_slaughter_order.json")}
  end

  def render("show.json", %{livestock_order_slaughter_order: livestock_order_slaughter_order}) do
    %{data: render_one(livestock_order_slaughter_order, LivestockOrderSlaughterOrderView, "livestock_order_slaughter_order.json")}
  end

  def render("livestock_order_slaughter_order.json", %{livestock_order_slaughter_order: livestock_order_slaughter_order}) do
    %{
      id: livestock_order_slaughter_order.id,
      status: livestock_order_slaughter_order.status,
      description: livestock_order_slaughter_order.description,
      dates: livestock_order_slaughter_order.dates,
      business_id: livestock_order_slaughter_order.business_id,
      slaughter_order_bundler_id: livestock_order_slaughter_order.slaughter_order_bundler_id,
      livestock_order_processing_stage_id: livestock_order_slaughter_order.livestock_order_processing_stage_id,
      livestock_order_stage_id: livestock_order_slaughter_order.livestock_order_stage_id,
      livestock_order_id: livestock_order_slaughter_order.livestock_order_id,
      livestock_order: render_one(livestock_order_slaughter_order.livestock_order, __MODULE__, "livestock_order.json", as: :livestock_order),
      livestock_order_slaughter_order_outputs: render_many(livestock_order_slaughter_order.livestock_order_slaughter_order_outputs, LivestockOrderSlaughterOrderOutputView, "livestock_order_slaughter_order_output.json", as: :livestock_order_slaughter_order_output),
      business: render_one(livestock_order_slaughter_order.business, BusinessView, "business.json", as: :business)
    }
  end

  def render("livestock_order.json", %{livestock_order: livestock_order}) do
    %{
      id: livestock_order.id,
      quantity: livestock_order.quantity,
      d_livestock_id: livestock_order.d_livestock_id,
      livestock_order_container_id: livestock_order.livestock_order_container_id,
      d_livestock: render_one(livestock_order.d_livestock, DLivestockView, "d_livestock.json", as: :d_livestock),
    }
  end

end
