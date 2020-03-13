defmodule SpiderWeb.TrainView do
  use SpiderWeb, :view
  alias SpiderWeb.TrainView

  def render("index.json", %{trains: trains}) do
    %{data: render_many(trains, TrainView, "train.json")}
  end

  def render("show.json", %{train: train}) do
    %{data: render_one(train, TrainView, "train.json")}
  end

  def render("train.json", %{train: train}) do
    %{id: train.id,
      unique_number: train.unique_number}
  end
end
