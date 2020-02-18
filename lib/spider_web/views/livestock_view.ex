defmodule SpiderWeb.LivestockView do
  use SpiderWeb, :view
  alias SpiderWeb.LivestockView

  def render("index.json", %{livestocks: livestocks}) do
    %{data: render_many(livestocks, LivestockView, "livestock.json")}
  end

  def render("show.json", %{livestock: livestock}) do
    %{data: render_one(livestock, LivestockView, "livestock.json")}
  end

  def render("livestock.json", %{livestock: livestock}) do
    %{
      id: livestock.id,
      type: livestock.type,
      category: livestock.category,
      number: livestock.number,
      user_id: livestock.user_id,
      business_id: livestock.business_id
    }
  end
end
