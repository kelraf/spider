defmodule SpiderWeb.TransporterRoleController do
  use SpiderWeb, :controller

  alias Spider.TransporterRoles
  alias Spider.TransporterRoles.TransporterRole

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    transporterroles = TransporterRoles.list_transporterroles()
    render(conn, "index.json", transporterroles: transporterroles)
  end

  def create(conn, %{"transporter_role" => transporter_role_params}) do
    with {:ok, %TransporterRole{} = transporter_role} <- TransporterRoles.create_transporter_role(transporter_role_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", transporter_role_path(conn, :show, transporter_role))
      |> render("show.json", transporter_role: transporter_role)
    end
  end

  def show(conn, %{"id" => id}) do
    transporter_role = TransporterRoles.get_transporter_role!(id)
    render(conn, "show.json", transporter_role: transporter_role)
  end

  def update(conn, %{"id" => id, "transporter_role" => transporter_role_params}) do
    transporter_role = TransporterRoles.get_transporter_role!(id)

    with {:ok, %TransporterRole{} = transporter_role} <- TransporterRoles.update_transporter_role(transporter_role, transporter_role_params) do
      render(conn, "show.json", transporter_role: transporter_role)
    end
  end

  def delete(conn, %{"id" => id}) do
    transporter_role = TransporterRoles.get_transporter_role!(id)
    with {:ok, %TransporterRole{}} <- TransporterRoles.delete_transporter_role(transporter_role) do
      send_resp(conn, :no_content, "")
    end
  end
end
