defmodule SpiderWeb.TraincView do
  use SpiderWeb, :view
  alias SpiderWeb.TraincView

  def render("index.json", %{traincs: traincs}) do
    %{data: render_many(traincs, TraincView, "trainc.json")}
  end

  def render("show.json", %{trainc: trainc}) do
    %{data: render_one(trainc, TraincView, "trainc.json")}
  end

  def render("trainc.json", %{trainc: trainc}) do
    %{id: trainc.id,
      unique_number: trainc.unique_number,
      role: trainc.role}
  end
end
