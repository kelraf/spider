defmodule SpiderWeb.LivestockOrderView do
  use SpiderWeb, :view
  alias SpiderWeb.LivestockOrderView
  alias SpiderWeb.CenterOrderView
  alias SpiderWeb.DLivestockView

  def render("index.json", %{livestock_orders: livestock_orders}) do
    %{data: render_many(livestock_orders, LivestockOrderView, "livestock_order.json")}
  end

  def render("show.json", %{livestock_order: livestock_order}) do
    %{data: render_one(livestock_order, LivestockOrderView, "livestock_order.json")}
  end

  def render("livestock_order.json", %{livestock_order: livestock_order}) do
    %{
      id: livestock_order.id,
      price: livestock_order.price,
      total_cost: livestock_order.total_cost,
      quantity: livestock_order.quantity,
      dlivestock_id: livestock_order.dlivestock_id,
      livestock_order_container_id: livestock_order.livestock_order_container_id,
      dlivestock: render_one(livestock_order.dlivestock, DLivestockView, "d_livestock.json", as: :d_livestock),
      center_order: render_one(livestock_order.center_order, CenterOrderView, "center_order.json", as: :center_order)
    }
  end
end
