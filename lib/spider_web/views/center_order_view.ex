defmodule SpiderWeb.CenterOrderView do
  use SpiderWeb, :view
  alias SpiderWeb.CenterOrderView
  alias SpiderWeb.LivestockSaleView

  def render("index.json", %{center_orders: center_orders}) do
    %{data: render_many(center_orders, CenterOrderView, "center_order.json")}
  end

  def render("show.json", %{center_order: center_order}) do
    %{data: render_one(center_order, CenterOrderView, "center_order.json")}
  end

  def render("center_order.json", %{center_order: center_order}) do
    %{
      id: center_order.id,
      required_animals: center_order.required_animals,
      available_animals: center_order.available_animals,
      status: center_order.status,
      price_per_animal: center_order.price_per_animal,
      total_price: center_order.total_price,
      who_can_see: center_order.who_can_see,
      description: center_order.description,
      d_livestock_id: center_order.d_livestock_id,
      livestock_order_id: center_order.livestock_order_id,
      total_price_available: center_order.total_price_available,
      livestock_sales:
        render_many(center_order.livestock_sales, LivestockSaleView, "livestock_sale.json",
          as: :livestock_sale
        )
    }
  end
end
