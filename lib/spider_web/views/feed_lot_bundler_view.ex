defmodule SpiderWeb.FeedLotBundlerView do
  use SpiderWeb, :view
  alias SpiderWeb.FeedLotBundlerView
  alias SpiderWeb.BusinessView
  alias SpiderWeb.DLivestockView

  def render("index.json", %{feed_lot_bundlers: feed_lot_bundlers}) do
    %{data: render_many(feed_lot_bundlers, FeedLotBundlerView, "feed_lot_bundler.json")}
  end

  def render("show.json", %{feed_lot_bundler: feed_lot_bundler}) do
    %{data: render_one(feed_lot_bundler, FeedLotBundlerView, "feed_lot_bundler.json")}
  end

  def render("feed_lot_bundler.json", %{feed_lot_bundler: feed_lot_bundler}) do
    %{
      id: feed_lot_bundler.id,
      business_id: feed_lot_bundler.business_id,
      business: render_one(feed_lot_bundler.business, BusinessView, "business.json", as: :business)
      |> Map.drop([
        :business_pin, 
        :registration_number
      ]),
      feed_lot_livestock_orders: render_many(feed_lot_bundler.feed_lot_livestock_orders, __MODULE__, "feed_lot_livestock_order.json", as: :feed_lot_livestock_order)
    }
  end

  def render("feed_lot_livestock_order.json", %{feed_lot_livestock_order: feed_lot_livestock_order}) do
    %{
      id: feed_lot_livestock_order.id,
      dates: feed_lot_livestock_order.dates,
      status: feed_lot_livestock_order.status,
      feed_lot_bundler_id: feed_lot_livestock_order.feed_lot_bundler_id,
      livestock_order_stage_id: feed_lot_livestock_order.livestock_order_stage_id,
      livestock_order_id: feed_lot_livestock_order.livestock_order_id,
      livestock_order: render_one(feed_lot_livestock_order.livestock_order, __MODULE__, "livestock_order.json", as: :livestock_order),
    }
  end

  def render("livestock_order.json", %{livestock_order: livestock_order}) do
    %{
      id: livestock_order.id,
      price: livestock_order.price,
      total_cost: livestock_order.total_cost,
      quantity: livestock_order.quantity,
      d_livestock_id: livestock_order.d_livestock_id,
      d_livestock: render_one(livestock_order.d_livestock, DLivestockView, "d_livestock.json", as: :d_livestock),
    }
  end

end
