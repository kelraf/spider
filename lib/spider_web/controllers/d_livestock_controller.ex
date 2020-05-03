defmodule SpiderWeb.DLivestockController do
  use SpiderWeb, :controller

  alias Spider.DLivestocks
  alias Spider.DLivestocks.DLivestock

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    dlivestock = DLivestocks.list_dlivestock()
    render(conn, "index.json", dlivestock: dlivestock)
  end

  def create(conn, %{"d_livestock" => d_livestock_params}) do
    with {:ok, %DLivestock{} = d_livestock} <- DLivestocks.create_d_livestock(d_livestock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", d_livestock_path(conn, :show, d_livestock))
      |> render("show.json", d_livestock: d_livestock)
    end
  end

  def show(conn, %{"id" => id}) do
    d_livestock = DLivestocks.get_d_livestock!(id)
    render(conn, "show.json", d_livestock: d_livestock)
  end

  def update(conn, %{"id" => id, "d_livestock" => d_livestock_params}) do
    d_livestock = DLivestocks.get_d_livestock!(id)

    with {:ok, %DLivestock{} = d_livestock} <- DLivestocks.update_d_livestock(d_livestock, d_livestock_params) do
      render(conn, "show.json", d_livestock: d_livestock)
    end
  end

  def delete(conn, %{"id" => id}) do
    d_livestock = DLivestocks.get_d_livestock!(id)
    with {:ok, %DLivestock{}} <- DLivestocks.delete_d_livestock(d_livestock) do
      send_resp(conn, :no_content, "")
    end
  end
end
