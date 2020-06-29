defmodule SpiderWeb.SlaughterOrderBundlerView do
  use SpiderWeb, :view
  alias SpiderWeb.SlaughterOrderBundlerView
  alias SpiderWeb.BusinessView
  alias SpiderWeb.LivestockOrderSlaughterOrderView

  def render("index.json", %{slaughter_order_bundlers: slaughter_order_bundlers}) do
    %{data: render_many(slaughter_order_bundlers, SlaughterOrderBundlerView, "slaughter_order_bundler.json")}
  end

  def render("show.json", %{slaughter_order_bundler: slaughter_order_bundler}) do
    %{data: render_one(slaughter_order_bundler, SlaughterOrderBundlerView, "slaughter_order_bundler.json")}
  end

  def render("slaughter_order_bundler.json", %{slaughter_order_bundler: slaughter_order_bundler}) do
    %{
      id: slaughter_order_bundler.id,
      business_id: slaughter_order_bundler.business_id,
      business: render_one(slaughter_order_bundler.business, BusinessView, "business.json", as: :business),
      livestock_order_slaughter_orders: render_many(slaughter_order_bundler.livestock_order_slaughter_orders, LivestockOrderSlaughterOrderView, "livestock_order_slaughter_order.json", as: :livestock_order_slaughter_order)
    }
  end
end
