defmodule SpiderWeb.DProduceView do
  use SpiderWeb, :view
  alias SpiderWeb.DProduceView

  def render("index.json", %{dproduces: dproduces}) do
    %{data: render_many(dproduces, DProduceView, "d_produce.json")}
  end

  def render("show.json", %{d_produce: d_produce}) do
    %{data: render_one(d_produce, DProduceView, "d_produce.json")}
  end

  def render("d_produce.json", %{d_produce: d_produce}) do
    %{id: d_produce.id,
      reference: d_produce.reference,
      category: d_produce.category,
      units: d_produce.units}
  end
end
