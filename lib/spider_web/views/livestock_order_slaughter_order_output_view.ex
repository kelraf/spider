defmodule SpiderWeb.LivestockOrderSlaughterOrderOutputView do
  use SpiderWeb, :view
  alias SpiderWeb.LivestockOrderSlaughterOrderOutputView
  alias SpiderWeb.DLivestockSlaughterOutputView 

  def render("index.json", %{livestock_order_slaughter_order_outputs: livestock_order_slaughter_order_outputs}) do
    %{data: render_many(livestock_order_slaughter_order_outputs, LivestockOrderSlaughterOrderOutputView, "livestock_order_slaughter_order_output.json")}
  end

  def render("show.json", %{livestock_order_slaughter_order_output: livestock_order_slaughter_order_output}) do
    %{data: render_one(livestock_order_slaughter_order_output, LivestockOrderSlaughterOrderOutputView, "livestock_order_slaughter_order_output.json")}
  end

  def render("livestock_order_slaughter_order_output.json", %{livestock_order_slaughter_order_output: livestock_order_slaughter_order_output}) do
    %{
      id: livestock_order_slaughter_order_output.id,
      quantity: livestock_order_slaughter_order_output.quantity,
      status: livestock_order_slaughter_order_output.status,
      d_livestock_slaughter_output_id: livestock_order_slaughter_order_output.d_livestock_slaughter_output_id,
      livestock_order_slaughter_order_id: livestock_order_slaughter_order_output.livestock_order_slaughter_order_id,
      livestock_order_id: livestock_order_slaughter_order_output.livestock_order_id,
      livestock_order_stage_id: livestock_order_slaughter_order_output.livestock_order_stage_id,
      livestock_order_processing_stage_id: livestock_order_slaughter_order_output.livestock_order_processing_stage_id,
      d_livestock_slaughter_output: render_one(livestock_order_slaughter_order_output.d_livestock_slaughter_output, DLivestockSlaughterOutputView, "d_livestock_slaughter_output.json", as: :d_livestock_slaughter_output)
    }
  end
end
