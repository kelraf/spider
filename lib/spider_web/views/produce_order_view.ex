defmodule SpiderWeb.ProduceOrderView do
  use SpiderWeb, :view
  alias SpiderWeb.ProduceOrderView
  alias SpiderWeb.DProduceView

  def render("index.json", %{produce_orders: produce_orders}) do
    %{data: render_many(produce_orders, ProduceOrderView, "produce_order.json")}
  end

  def render("show.json", %{produce_order: produce_order}) do
    %{data: render_one(produce_order, ProduceOrderView, "produce_order.json")}
  end

  def render("produce_order.json", %{produce_order: produce_order}) do
    %{
      id: produce_order.id,
      price_per_unit: produce_order.price_per_unit,
      quantity: produce_order.quantity,
      total_cost: produce_order.total_cost,
      produce_order_container_id: produce_order.produce_order_container_id,
      d_produce_id: produce_order.d_produce_id,
      d_produce: render_one(produce_order.d_produce, DProduceView, "d_produce.json", as: :d_produce)
    }
  end
end
