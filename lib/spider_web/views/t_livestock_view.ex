defmodule SpiderWeb.TLivestockView do
  use SpiderWeb, :view
  alias SpiderWeb.TLivestockView

  def render("index.json", %{tlivestocks: tlivestocks}) do
    %{data: render_many(tlivestocks, TLivestockView, "t_livestock.json")}
  end

  def render("show.json", %{t_livestock: t_livestock}) do
    %{data: render_one(t_livestock, TLivestockView, "t_livestock.json")}
  end

  def render("t_livestock.json", %{t_livestock: t_livestock}) do
    %{
      id: t_livestock.id,
      quantity: t_livestock.quantity,
      livestock_id: t_livestock.livestock_id,
      inserted_at: t_livestock.inserted_at,
      updated_at: t_livestock.updated_at
    }
  end
end
