defmodule SpiderWeb.TransporterRoleView do
  use SpiderWeb, :view
  alias SpiderWeb.TransporterRoleView

  def render("index.json", %{transporterroles: transporterroles}) do
    %{data: render_many(transporterroles, TransporterRoleView, "transporter_role.json")}
  end

  def render("show.json", %{transporter_role: transporter_role}) do
    %{data: render_one(transporter_role, TransporterRoleView, "transporter_role.json")}
  end

  def render("transporter_role.json", %{transporter_role: transporter_role}) do
    %{id: transporter_role.id}
  end
end
