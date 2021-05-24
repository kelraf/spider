defmodule SpiderWeb.VessleController do
  use SpiderWeb, :controller

  alias Spider.Vessles
  alias Spider.Vessles.Vessle
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    vessles = Vessles.list_vessles() |> Repo.preload(:eroles)
    render(conn, "index.json", vessles: vessles)
  end

  def get_vessles_using_business_id(conn, %{"business_id" => business_id}) do
    
    case Vessles.get_vessles_using_business_id(business_id) do
      {:empty, _rubish} ->
        conn
        |> json(%{
          data: [],
          message: "No Vessels Related Your Business"
        })

      {:ok, vessles} ->
        conn
        |> render("index.json", vessles: vessles |> Repo.preload(:eroles))
        
    end

  end

  def create(conn, %{"vessle" => vessle_params}) do
    with {:ok, %Vessle{} = vessle} <- Vessles.create_vessle(vessle_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", vessle_path(conn, :show, vessle))
      |> render("show.json", vessle: vessle |> Repo.preload(:eroles))
    end
  end

  def show(conn, %{"id" => id}) do
    vessle = Vessles.get_vessle!(id) |> Repo.preload(:eroles)
    render(conn, "show.json", vessle: vessle)
  end

  def update(conn, %{"id" => id, "vessle" => vessle_params}) do
    vessle = Vessles.get_vessle!(id)

    with {:ok, %Vessle{} = vessle} <- Vessles.update_vessle(vessle, vessle_params) do
      render(conn, "show.json", vessle: vessle |> Repo.preload(:eroles))
    end
  end

  def delete(conn, %{"id" => id}) do
    vessle = Vessles.get_vessle!(id)
    with {:ok, %Vessle{}} <- Vessles.delete_vessle(vessle) do
      send_resp(conn, :no_content, "")
    end
  end
end
