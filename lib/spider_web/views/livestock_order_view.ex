defmodule SpiderWeb.LivestockOrderView do
  use SpiderWeb, :view
  alias SpiderWeb.LivestockOrderView
  alias SpiderWeb.CenterOrderView
  alias SpiderWeb.DLivestockView
  alias SpiderWeb.LivestockOrderStageView

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
      d_livestock_id: livestock_order.d_livestock_id,
      livestock_order_container_id: livestock_order.livestock_order_container_id,
      d_livestock: render_one(livestock_order.d_livestock, DLivestockView, "d_livestock.json", as: :d_livestock),
      livestock_order_stages: render_many(livestock_order.livestock_order_stages, LivestockOrderStageView, "livestock_order_stage.json", as: :livestock_order_stage)
    }
  end
end
