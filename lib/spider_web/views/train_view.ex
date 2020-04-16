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
    %{
      id: train.id,
      unique_number: train.unique_number,
      business_id: train.business_id,
      status: train.status,
      user_id: train.user_id,
      troles: render_many(train.troles, TrainView, "t_role.json", as: :t_role)
    }
  end

  def render("t_role.json", %{t_role: t_role}) do
    %{
      id: t_role.id,
      capacity: t_role.capacity,
      train_id: t_role.train_id,
      drole_id: t_role.drole_id
    }
  end

end
