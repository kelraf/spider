defmodule SpiderWeb.DRoleController do
  use SpiderWeb, :controller

  alias Spider.DRoles
  alias Spider.DRoles.DRole

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    droles = DRoles.list_droles()
    render(conn, "index.json", droles: droles)
  end

  def create(conn, %{"d_role" => d_role_params}) do
    with {:ok, %DRole{} = d_role} <- DRoles.create_d_role(d_role_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", d_role_path(conn, :show, d_role))
      |> render("show.json", d_role: d_role)
    end
  end

  def show(conn, %{"id" => id}) do
    d_role = DRoles.get_d_role!(id)
    render(conn, "show.json", d_role: d_role)
  end

  def update(conn, %{"id" => id, "d_role" => d_role_params}) do
    d_role = DRoles.get_d_role!(id)

    with {:ok, %DRole{} = d_role} <- DRoles.update_d_role(d_role, d_role_params) do
      render(conn, "show.json", d_role: d_role)
    end
  end

  def delete(conn, %{"id" => id}) do
    d_role = DRoles.get_d_role!(id)
    with {:ok, %DRole{}} <- DRoles.delete_d_role(d_role) do
      send_resp(conn, :no_content, "")
    end
  end
end
