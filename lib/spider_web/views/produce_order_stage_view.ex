defmodule SpiderWeb.ProduceOrderStageView do
  use SpiderWeb, :view
  alias SpiderWeb.ProduceOrderStageView
  alias  SpiderWeb.ProduceCenterOrderView
  alias SpiderWeb.CCPPOrderView

  def render("index.json", %{produce_order_stages: produce_order_stages}) do
    %{data: render_many(produce_order_stages, ProduceOrderStageView, "produce_order_stage.json")}
  end

  def render("show.json", %{produce_order_stage: produce_order_stage}) do
    %{data: render_one(produce_order_stage, ProduceOrderStageView, "produce_order_stage.json")}
  end

  def render("produce_order_stage.json", %{produce_order_stage: produce_order_stage}) do
    %{
      id: produce_order_stage.id,
      stage_name: produce_order_stage.stage_name,
      stage_number: produce_order_stage.stage_number,
      status: produce_order_stage.status,
      produce_order_id: produce_order_stage.produce_order_id,
      produce_center_order: render_one(produce_order_stage.produce_center_order, ProduceCenterOrderView, "produce_center_order.json", as: :produce_center_order),
      c_c_p_p_orders: render_many(produce_order_stage.c_c_p_p_orders, CCPPOrderView, "ccpp_order.json", as: :ccpp_order)
    }
  end
end
