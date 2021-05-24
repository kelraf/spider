defmodule SpiderWeb.LivestockSaleView do
  use SpiderWeb, :view
  alias SpiderWeb.LivestockSaleView
  alias SpiderWeb.BusinessView
  alias SpiderWeb.DLivestockView

  def render("index.json", %{livestock_sales: livestock_sales}) do
    %{data: render_many(livestock_sales, LivestockSaleView, "livestock_sale.json")}
  end

  def render("show.json", %{livestock_sale: livestock_sale}) do
    %{data: render_one(livestock_sale, LivestockSaleView, "livestock_sale.json")}
  end

  def render("livestock_sale.json", %{livestock_sale: livestock_sale}) do
    %{
      id: livestock_sale.id,
      quantity: livestock_sale.quantity,
      price_per_animal: livestock_sale.price_per_animal,
      total_price: livestock_sale.total_price,
      center_order_id: livestock_sale.center_order_id,
      livestock_id: livestock_sale.livestock_id,
      business_id: livestock_sale.business_id,
      user_id: livestock_sale.user_id,
      d_livestock_id: livestock_sale.d_livestock_id,
      status: livestock_sale.status,
      business: render_one(livestock_sale.business, BusinessView, "business.json", as: :business),
      d_livestock: render_one(livestock_sale.d_livestock, DLivestockView, "d_livestock.json", as: :d_livestock)
    }
  end
end
