defmodule SpiderWeb.TrainController do
  use SpiderWeb, :controller

  alias Spider.Trains
  alias Spider.Trains.Train
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    trains = Trains.list_trains() |> Repo.preload(:troles)
    render(conn, "index.json", trains: trains)
  end

  def get_trains_using_business_id(conn, %{"business_id" => business_id}) do
    
    case Trains.get_trains_using_business_id(business_id) do
      {:empty, _rubish} ->
        conn
        |> json(%{
          data: [],
          message: "No Trains Related Your Business"
        })

      {:ok, trains} ->
        conn
        |> render("index.json", trains: trains |> Repo.preload(:troles))
        
    end

  end

  def create(conn, %{"train" => train_params}) do
    with {:ok, %Train{} = train} <- Trains.create_train(train_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", train_path(conn, :show, train))
      |> render("show.json", train: train |> Repo.preload(:troles))
    end
  end

  def show(conn, %{"id" => id}) do
    train = Trains.get_train!(id)  |> Repo.preload(:troles)
    render(conn, "show.json", train: train)
  end

  def update(conn, %{"id" => id, "train" => train_params}) do
    train = Trains.get_train!(id)

    with {:ok, %Train{} = train} <- Trains.update_train(train, train_params) do
      render(conn, "show.json", train: train  |> Repo.preload(:troles))
    end
  end

  def delete(conn, %{"id" => id}) do
    train = Trains.get_train!(id)
    with {:ok, %Train{}} <- Trains.delete_train(train) do
      send_resp(conn, :no_content, "")
    end
  end
end
