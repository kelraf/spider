defmodule SpiderWeb.VRoleView do
  use SpiderWeb, :view
  alias SpiderWeb.VRoleView

  def render("index.json", %{vroles: vroles}) do
    %{data: render_many(vroles, VRoleView, "v_role.json")}
  end

  def render("show.json", %{v_role: v_role}) do
    %{data: render_one(v_role, VRoleView, "v_role.json")}
  end

  def render("v_role.json", %{v_role: v_role}) do
    %{id: v_role.id}
  end
end
