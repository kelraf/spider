defmodule SpiderWeb.AdminTransporterRoleView do
  use SpiderWeb, :view
  alias SpiderWeb.AdminTransporterRoleView

  def render("index.json", %{admintransporterroles: admintransporterroles}) do
    %{data: render_many(admintransporterroles, AdminTransporterRoleView, "admin_transporter_role.json")}
  end

  def render("show.json", %{admin_transporter_role: admin_transporter_role}) do
    %{data: render_one(admin_transporter_role, AdminTransporterRoleView, "admin_transporter_role.json")}
  end

  def render("admin_transporter_role.json", %{admin_transporter_role: admin_transporter_role}) do
    %{id: admin_transporter_role.id,
      role: admin_transporter_role.role}
  end
end
