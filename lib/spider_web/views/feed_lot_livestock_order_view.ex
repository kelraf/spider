defmodule SpiderWeb.FeedLotLivestockOrderView do
  use SpiderWeb, :view
  alias SpiderWeb.FeedLotLivestockOrderView
  alias SpiderWeb.FeedLotBundlerView

  def render("index.json", %{feed_lot_livestock_orders: feed_lot_livestock_orders}) do
    %{data: render_many(feed_lot_livestock_orders, FeedLotLivestockOrderView, "feed_lot_livestock_order.json")}
  end

  def render("show.json", %{feed_lot_livestock_order: feed_lot_livestock_order}) do
    %{data: render_one(feed_lot_livestock_order, FeedLotLivestockOrderView, "feed_lot_livestock_order.json")}
  end

  def render("feed_lot_livestock_order.json", %{feed_lot_livestock_order: feed_lot_livestock_order}) do
    %{
      id: feed_lot_livestock_order.id,
      dates: feed_lot_livestock_order.dates,
      status: feed_lot_livestock_order.status,
      feed_lot_bundler_id: feed_lot_livestock_order.feed_lot_bundler_id,
      livestock_order_stage_id: feed_lot_livestock_order.livestock_order_stage_id,
      livestock_order_id: feed_lot_livestock_order.livestock_order_id,
      feed_lot_bundler: render_one(feed_lot_livestock_order.feed_lot_bundler, FeedLotBundlerView, "feed_lot_bundler.json", as: :feed_lot_bundler)
    }
  end
  
end
