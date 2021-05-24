defmodule SpiderWeb.TRoleController do
  use SpiderWeb, :controller

  alias Spider.TRoles
  alias Spider.TRoles.TRole

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    troles = TRoles.list_troles()
    render(conn, "index.json", troles: troles)
  end

  def create(conn, %{"t_role" => t_role_params}) do
    with {:ok, %TRole{} = t_role} <- TRoles.create_t_role(t_role_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", t_role_path(conn, :show, t_role))
      |> render("show.json", t_role: t_role)
    end
  end

  def show(conn, %{"id" => id}) do
    t_role = TRoles.get_t_role!(id)
    render(conn, "show.json", t_role: t_role)
  end

  def update(conn, %{"id" => id, "t_role" => t_role_params}) do
    t_role = TRoles.get_t_role!(id)

    with {:ok, %TRole{} = t_role} <- TRoles.update_t_role(t_role, t_role_params) do
      render(conn, "show.json", t_role: t_role)
    end
  end

  def delete(conn, %{"id" => id}) do
    t_role = TRoles.get_t_role!(id)
    with {:ok, %TRole{}} <- TRoles.delete_t_role(t_role) do
      send_resp(conn, :no_content, "")
    end
  end
end
