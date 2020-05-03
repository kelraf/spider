defmodule SpiderWeb.TLivestockController do
  use SpiderWeb, :controller

  alias Spider.TLivestocks
  alias Spider.TLivestocks.TLivestock

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    tlivestocks = TLivestocks.list_tlivestocks()
    render(conn, "index.json", tlivestocks: tlivestocks)
  end

  def create(conn, %{"t_livestock" => t_livestock_params}) do
    with {:ok, %TLivestock{} = t_livestock} <- TLivestocks.create_t_livestock(t_livestock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", t_livestock_path(conn, :show, t_livestock))
      |> render("show.json", t_livestock: t_livestock)
    end
  end

  def show(conn, %{"id" => id}) do
    t_livestock = TLivestocks.get_t_livestock!(id)
    render(conn, "show.json", t_livestock: t_livestock)
  end

  def update(conn, %{"id" => id, "t_livestock" => t_livestock_params}) do
    t_livestock = TLivestocks.get_t_livestock!(id)

    with {:ok, %TLivestock{} = t_livestock} <- TLivestocks.update_t_livestock(t_livestock, t_livestock_params) do
      render(conn, "show.json", t_livestock: t_livestock)
    end
  end

  def delete(conn, %{"id" => id}) do
    t_livestock = TLivestocks.get_t_livestock!(id)
    with {:ok, %TLivestock{}} <- TLivestocks.delete_t_livestock(t_livestock) do
      send_resp(conn, :no_content, "")
    end
  end
end
