defmodule SpiderWeb.ProduceView do
  use SpiderWeb, :view
  alias SpiderWeb.ProduceView

  def render("index.json", %{produces: produces}) do
    %{data: render_many(produces, ProduceView, "produce.json")}
  end

  def render("show.json", %{produce: produce}) do
    %{data: render_one(produce, ProduceView, "produce.json")}
  end

  def render("produce.json", %{produce: produce}) do
    %{
      id: produce.id,
      quantity: produce.quantity,
      dproduce_id: produce.dproduce_id,
      user_id: produce.user_id,
      business_id: produce.business_id
    }
  end
end
