defmodule SpiderWeb.TranstoolController do
  use SpiderWeb, :controller

  alias Spider.Transtools
  alias Spider.Transtools.Transtool

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    transtools = Transtools.list_transtools()
    render(conn, "index.json", transtools: transtools)
  end

  def create(conn, %{"transtool" => transtool_params}) do
    with {:ok, %Transtool{} = transtool} <- Transtools.create_transtool(transtool_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", transtool_path(conn, :show, transtool))
      |> render("show.json", transtool: transtool)
    end
  end

  def show(conn, %{"id" => id}) do
    transtool = Transtools.get_transtool!(id)
    render(conn, "show.json", transtool: transtool)
  end

  def update(conn, %{"id" => id, "transtool" => transtool_params}) do
    transtool = Transtools.get_transtool!(id)

    with {:ok, %Transtool{} = transtool} <- Transtools.update_transtool(transtool, transtool_params) do
      render(conn, "show.json", transtool: transtool)
    end
  end

  def delete(conn, %{"id" => id}) do
    transtool = Transtools.get_transtool!(id)
    with {:ok, %Transtool{}} <- Transtools.delete_transtool(transtool) do
      send_resp(conn, :no_content, "")
    end
  end
end
