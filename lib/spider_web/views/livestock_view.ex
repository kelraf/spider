defmodule SpiderWeb.LivestockView do
  use SpiderWeb, :view
  alias SpiderWeb.LivestockView
  alias SpiderWeb.TLivestockView

  def render("index.json", %{livestocks: livestocks}) do
    %{data: render_many(livestocks, LivestockView, "livestock.json")}
  end

  def render("show.json", %{livestock: livestock}) do
    %{data: render_one(livestock, LivestockView, "livestock.json")}
  end

  def render("livestock.json", %{livestock: livestock}) do
    %{
      id: livestock.id,
      dlivestock_id: livestock.dlivestock_id,
      quantity: livestock.quantity,
      price: livestock.price,
      user_id: livestock.user_id,
      business_id: livestock.business_id,
      tlivestocks: render_many(livestock.tlivestocks, TLivestockView, "t_livestock.json", as: :t_livestock)
    }
  end
end
