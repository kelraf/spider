defmodule SpiderWeb.FroleController do
  use SpiderWeb, :controller

  alias Spider.Froles
  alias Spider.Froles.Frole 

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    froles = Froles.list_froles()
    render(conn, "index.json", froles: froles)
  end

  def create(conn, %{"frole" => frole_params}) do
    with {:ok, %Frole{} = frole} <- Froles.create_frole(frole_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", frole_path(conn, :show, frole))
      |> render("show.json", frole: frole)
    end
  end

  def show(conn, %{"id" => id}) do
    frole = Froles.get_frole!(id)
    render(conn, "show.json", frole: frole)
  end

  def update(conn, %{"id" => id, "frole" => frole_params}) do
    frole = Froles.get_frole!(id)

    with {:ok, %Frole{} = frole} <- Froles.update_frole(frole, frole_params) do
      render(conn, "show.json", frole: frole)
    end
  end

  def delete(conn, %{"id" => id}) do
    frole = Froles.get_frole!(id)
    with {:ok, %Frole{}} <- Froles.delete_frole(frole) do
      send_resp(conn, :no_content, "")
    end
  end
end
