defmodule SpiderWeb.LivestockOrderStageView do
  use SpiderWeb, :view
  alias SpiderWeb.LivestockOrderStageView
  alias SpiderWeb.CenterOrderView
  alias SpiderWeb.CCPLOrderView
  alias SpiderWeb.ExportZoneLivestockOrderView

  def render("index.json", %{livestock_order_stages: livestock_order_stages}) do
    %{
      data:
        render_many(livestock_order_stages, LivestockOrderStageView, "livestock_order_stage.json")
    }
  end

  def render("show.json", %{livestock_order_stage: livestock_order_stage}) do
    %{
      data:
        render_one(livestock_order_stage, LivestockOrderStageView, "livestock_order_stage.json")
    }
  end

  def render("livestock_order_stage.json", %{livestock_order_stage: livestock_order_stage}) do
    %{
      id: livestock_order_stage.id,
      stage_name: livestock_order_stage.stage_name,
      status: livestock_order_stage.status,
      livestock_order_id: livestock_order_stage.livestock_order_id,
      center_order:
        render_one(livestock_order_stage.center_order, CenterOrderView, "center_order.json",
          as: :center_order
        ),
      c_c_p_l_orders:
        render_many(livestock_order_stage.c_c_p_l_orders, CCPLOrderView, "ccpl_order.json",
          as: :ccpl_order
        ),
      export_zone_livestock_order: render_one(livestock_order_stage.export_zone_livestock_order, ExportZoneLivestockOrderView, "export_zone_livestock_order.json", as: :export_zone_livestock_order)
    }
  end
end
