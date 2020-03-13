defmodule SpiderWeb.VessleView do
  use SpiderWeb, :view
  alias SpiderWeb.VessleView

  def render("index.json", %{vessles: vessles}) do
    %{data: render_many(vessles, VessleView, "vessle.json")}
  end

  def render("show.json", %{vessle: vessle}) do
    %{data: render_one(vessle, VessleView, "vessle.json")}
  end

  def render("vessle.json", %{vessle: vessle}) do
    %{id: vessle.id,
      unique_number: vessle.unique_number,
      role: vessle.role}
  end
end
