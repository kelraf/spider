defmodule SpiderWeb.TraincController do
  use SpiderWeb, :controller

  alias Spider.Traincs
  alias Spider.Traincs.Trainc

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    traincs = Traincs.list_traincs()
    render(conn, "index.json", traincs: traincs)
  end

  def create(conn, %{"trainc" => trainc_params}) do
    with {:ok, %Trainc{} = trainc} <- Traincs.create_trainc(trainc_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", trainc_path(conn, :show, trainc))
      |> render("show.json", trainc: trainc)
    end
  end

  def show(conn, %{"id" => id}) do
    trainc = Traincs.get_trainc!(id)
    render(conn, "show.json", trainc: trainc)
  end

  def update(conn, %{"id" => id, "trainc" => trainc_params}) do
    trainc = Traincs.get_trainc!(id)

    with {:ok, %Trainc{} = trainc} <- Traincs.update_trainc(trainc, trainc_params) do
      render(conn, "show.json", trainc: trainc)
    end
  end

  def delete(conn, %{"id" => id}) do
    trainc = Traincs.get_trainc!(id)
    with {:ok, %Trainc{}} <- Traincs.delete_trainc(trainc) do
      send_resp(conn, :no_content, "")
    end
  end
end
