defmodule SpiderWeb.DRoleView do
  use SpiderWeb, :view
  alias SpiderWeb.DRoleView

  def render("index.json", %{droles: droles}) do
    %{data: render_many(droles, DRoleView, "d_role.json")}
  end

  def render("show.json", %{d_role: d_role}) do
    %{data: render_one(d_role, DRoleView, "d_role.json")}
  end

  def render("d_role.json", %{d_role: d_role}) do
    %{id: d_role.id,
      role: d_role.role}
  end
end
