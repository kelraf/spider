defmodule SpiderWeb.AdminTransporterRoleController do
  use SpiderWeb, :controller

  alias Spider.AdminTransporterRoles
  alias Spider.AdminTransporterRoles.AdminTransporterRole

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    admintransporterroles = AdminTransporterRoles.list_admintransporterroles()
    render(conn, "index.json", admintransporterroles: admintransporterroles)
  end

  def create(conn, %{"admin_transporter_role" => admin_transporter_role_params}) do
    with {:ok, %AdminTransporterRole{} = admin_transporter_role} <- AdminTransporterRoles.create_admin_transporter_role(admin_transporter_role_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", admin_transporter_role_path(conn, :show, admin_transporter_role))
      |> render("show.json", admin_transporter_role: admin_transporter_role)
    end
  end

  def show(conn, %{"id" => id}) do
    admin_transporter_role = AdminTransporterRoles.get_admin_transporter_role!(id)
    render(conn, "show.json", admin_transporter_role: admin_transporter_role)
  end

  def update(conn, %{"id" => id, "admin_transporter_role" => admin_transporter_role_params}) do
    admin_transporter_role = AdminTransporterRoles.get_admin_transporter_role!(id)

    with {:ok, %AdminTransporterRole{} = admin_transporter_role} <- AdminTransporterRoles.update_admin_transporter_role(admin_transporter_role, admin_transporter_role_params) do
      render(conn, "show.json", admin_transporter_role: admin_transporter_role)
    end
  end

  def delete(conn, %{"id" => id}) do
    admin_transporter_role = AdminTransporterRoles.get_admin_transporter_role!(id)
    with {:ok, %AdminTransporterRole{}} <- AdminTransporterRoles.delete_admin_transporter_role(admin_transporter_role) do
      send_resp(conn, :no_content, "")
    end
  end
end
