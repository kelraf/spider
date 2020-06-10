defmodule SpiderWeb.LivestockOrderSlaughterOrderOutputView do
  use SpiderWeb, :view
  alias SpiderWeb.LivestockOrderSlaughterOrderOutputView

  def render("index.json", %{livestock_order_slaughter_order_outputs: livestock_order_slaughter_order_outputs}) do
    %{data: render_many(livestock_order_slaughter_order_outputs, LivestockOrderSlaughterOrderOutputView, "livestock_order_slaughter_order_output.json")}
  end

  def render("show.json", %{livestock_order_slaughter_order_output: livestock_order_slaughter_order_output}) do
    %{data: render_one(livestock_order_slaughter_order_output, LivestockOrderSlaughterOrderOutputView, "livestock_order_slaughter_order_output.json")}
  end

  def render("livestock_order_slaughter_order_output.json", %{livestock_order_slaughter_order_output: livestock_order_slaughter_order_output}) do
    %{
      id: livestock_order_slaughter_order_output.id,
      output_name: livestock_order_slaughter_order_output.output_name,
      quantity: livestock_order_slaughter_order_output.quantity,
      units: livestock_order_slaughter_order_output.units,
      status: livestock_order_slaughter_order_output.status,
      livestock_order_slaughter_order_id: livestock_order_slaughter_order_output.livestock_order_slaughter_order_id,
      livestock_order_id: livestock_order_slaughter_order_output.livestock_order_id,
      livestock_order_stage_id: livestock_order_slaughter_order_output.livestock_order_stage_id,
      livestock_order_processing_stage_id: livestock_order_slaughter_order_output.livestock_order_processing_stage_id
    }
  end
end
