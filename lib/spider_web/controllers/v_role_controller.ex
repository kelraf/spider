defmodule SpiderWeb.VRoleController do
  use SpiderWeb, :controller

  alias Spider.VRoles
  alias Spider.VRoles.VRole

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    vroles = VRoles.list_vroles()
    render(conn, "index.json", vroles: vroles)
  end

  def create(conn, %{"v_role" => v_role_params}) do
    with {:ok, %VRole{} = v_role} <- VRoles.create_v_role(v_role_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", v_role_path(conn, :show, v_role))
      |> render("show.json", v_role: v_role)
    end
  end

  def show(conn, %{"id" => id}) do
    v_role = VRoles.get_v_role!(id)
    render(conn, "show.json", v_role: v_role)
  end

  def update(conn, %{"id" => id, "v_role" => v_role_params}) do
    v_role = VRoles.get_v_role!(id)

    with {:ok, %VRole{} = v_role} <- VRoles.update_v_role(v_role, v_role_params) do
      render(conn, "show.json", v_role: v_role)
    end
  end

  def delete(conn, %{"id" => id}) do
    v_role = VRoles.get_v_role!(id)
    with {:ok, %VRole{}} <- VRoles.delete_v_role(v_role) do
      send_resp(conn, :no_content, "")
    end
  end
end
