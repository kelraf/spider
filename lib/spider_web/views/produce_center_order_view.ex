defmodule SpiderWeb.ProduceCenterOrderView do
  use SpiderWeb, :view
  alias SpiderWeb.ProduceCenterOrderView

  def render("index.json", %{produce_center_orders: produce_center_orders}) do
    %{data: render_many(produce_center_orders, ProduceCenterOrderView, "produce_center_order.json")}
  end

  def render("show.json", %{produce_center_order: produce_center_order}) do
    %{data: render_one(produce_center_order, ProduceCenterOrderView, "produce_center_order.json")}
  end

  def render("produce_center_order.json", %{produce_center_order: produce_center_order}) do
    %{
      id: produce_center_order.id,
      required_quantity: produce_center_order.required_quantity,
      available_quantity: produce_center_order.available_quantity,
      description: produce_center_order.description,
      status: produce_center_order.status,
      total_cost: produce_center_order.total_cost,
      who_can_see: produce_center_order.who_can_see,
      dates: produce_center_order.dates,
      produce_order_stage_id: produce_center_order.produce_order_stage_id,
      produce_order_id: produce_center_order.produce_order_id,
      d_produce_id: produce_center_order.d_produce_id
    }
  end
end
