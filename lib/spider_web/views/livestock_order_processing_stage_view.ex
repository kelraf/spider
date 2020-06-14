defmodule SpiderWeb.LivestockOrderProcessingStageView do

  use SpiderWeb, :view

  alias SpiderWeb.LivestockOrderProcessingStageView
  alias SpiderWeb.LivestockOrderSlaughterOrderView

  def render("index.json", %{livestock_order_processing_stages: livestock_order_processing_stages}) do
    %{data: render_many(livestock_order_processing_stages, LivestockOrderProcessingStageView, "livestock_order_processing_stage.json")}
  end

  def render("show.json", %{livestock_order_processing_stage: livestock_order_processing_stage}) do
    %{data: render_one(livestock_order_processing_stage, LivestockOrderProcessingStageView, "livestock_order_processing_stage.json")}
  end

  def render("livestock_order_processing_stage.json", %{livestock_order_processing_stage: livestock_order_processing_stage}) do
    %{
      id: livestock_order_processing_stage.id,
      stage_name: livestock_order_processing_stage.stage_name,
      status: livestock_order_processing_stage.status,
      livestock_order_id: livestock_order_processing_stage.livestock_order_id,
      livestock_order_stage_id: livestock_order_processing_stage.livestock_order_stage_id,
      livestock_order_slaughter_order: render_one(livestock_order_processing_stage.livestock_order_slaughter_order, LivestockOrderSlaughterOrderView, "livestock_order_slaughter_order.json", as: :livestock_order_slaughter_order) 
    }
  end
end
