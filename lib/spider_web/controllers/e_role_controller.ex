defmodule SpiderWeb.ERoleController do
  use SpiderWeb, :controller

  alias Spider.ERoles
  alias Spider.ERoles.ERole

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    eroles = ERoles.list_eroles()
    render(conn, "index.json", eroles: eroles)
  end

  def create(conn, %{"e_role" => e_role_params}) do
    with {:ok, %ERole{} = e_role} <- ERoles.create_e_role(e_role_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", e_role_path(conn, :show, e_role))
      |> render("show.json", e_role: e_role)
    end
  end

  def show(conn, %{"id" => id}) do
    e_role = ERoles.get_e_role!(id)
    render(conn, "show.json", e_role: e_role)
  end

  def update(conn, %{"id" => id, "e_role" => e_role_params}) do
    e_role = ERoles.get_e_role!(id)

    with {:ok, %ERole{} = e_role} <- ERoles.update_e_role(e_role, e_role_params) do
      render(conn, "show.json", e_role: e_role)
    end
  end

  def delete(conn, %{"id" => id}) do
    e_role = ERoles.get_e_role!(id)
    with {:ok, %ERole{}} <- ERoles.delete_e_role(e_role) do
      send_resp(conn, :no_content, "")
    end
  end
end
