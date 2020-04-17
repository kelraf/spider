defmodule SpiderWeb.DLivestockView do
  use SpiderWeb, :view
  alias SpiderWeb.DLivestockView

  def render("index.json", %{dlivestock: dlivestock}) do
    %{data: render_many(dlivestock, DLivestockView, "d_livestock.json")}
  end

  def render("show.json", %{d_livestock: d_livestock}) do
    %{data: render_one(d_livestock, DLivestockView, "d_livestock.json")}
  end

  def render("d_livestock.json", %{d_livestock: d_livestock}) do
    %{id: d_livestock.id,
      reference: d_livestock.reference,
      type: d_livestock.type,
      breed: d_livestock.breed,
      category: d_livestock.category}
  end
end
