defmodule SpiderWeb.VessleController do
  use SpiderWeb, :controller

  alias Spider.Vessles
  alias Spider.Vessles.Vessle

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    vessles = Vessles.list_vessles()
    render(conn, "index.json", vessles: vessles)
  end

  def create(conn, %{"vessle" => vessle_params}) do
    with {:ok, %Vessle{} = vessle} <- Vessles.create_vessle(vessle_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", vessle_path(conn, :show, vessle))
      |> render("show.json", vessle: vessle)
    end
  end

  def show(conn, %{"id" => id}) do
    vessle = Vessles.get_vessle!(id)
    render(conn, "show.json", vessle: vessle)
  end

  def update(conn, %{"id" => id, "vessle" => vessle_params}) do
    vessle = Vessles.get_vessle!(id)

    with {:ok, %Vessle{} = vessle} <- Vessles.update_vessle(vessle, vessle_params) do
      render(conn, "show.json", vessle: vessle)
    end
  end

  def delete(conn, %{"id" => id}) do
    vessle = Vessles.get_vessle!(id)
    with {:ok, %Vessle{}} <- Vessles.delete_vessle(vessle) do
      send_resp(conn, :no_content, "")
    end
  end
end
