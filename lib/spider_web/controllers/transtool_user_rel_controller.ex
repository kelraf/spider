defmodule SpiderWeb.TranstoolUserRelController do
  use SpiderWeb, :controller

  alias Spider.TranstoolUserRels
  alias Spider.TranstoolUserRels.TranstoolUserRel

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    transtooluserrels = TranstoolUserRels.list_transtooluserrels()
    render(conn, "index.json", transtooluserrels: transtooluserrels)
  end

  def create(conn, %{"transtool_user_rel" => transtool_user_rel_params}) do
    with {:ok, %TranstoolUserRel{} = transtool_user_rel} <- TranstoolUserRels.create_transtool_user_rel(transtool_user_rel_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", transtool_user_rel_path(conn, :show, transtool_user_rel))
      |> render("show.json", transtool_user_rel: transtool_user_rel)
    end
  end

  def show(conn, %{"id" => id}) do
    transtool_user_rel = TranstoolUserRels.get_transtool_user_rel!(id)
    render(conn, "show.json", transtool_user_rel: transtool_user_rel)
  end

  def update(conn, %{"id" => id, "transtool_user_rel" => transtool_user_rel_params}) do
    transtool_user_rel = TranstoolUserRels.get_transtool_user_rel!(id)

    with {:ok, %TranstoolUserRel{} = transtool_user_rel} <- TranstoolUserRels.update_transtool_user_rel(transtool_user_rel, transtool_user_rel_params) do
      render(conn, "show.json", transtool_user_rel: transtool_user_rel)
    end
  end

  def delete(conn, %{"id" => id}) do
    transtool_user_rel = TranstoolUserRels.get_transtool_user_rel!(id)
    with {:ok, %TranstoolUserRel{}} <- TranstoolUserRels.delete_transtool_user_rel(transtool_user_rel) do
      send_resp(conn, :no_content, "")
    end
  end
end
