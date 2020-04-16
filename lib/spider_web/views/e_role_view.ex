defmodule SpiderWeb.ERoleView do
  use SpiderWeb, :view
  alias SpiderWeb.ERoleView

  def render("index.json", %{eroles: eroles}) do
    %{data: render_many(eroles, ERoleView, "e_role.json")}
  end

  def render("show.json", %{e_role: e_role}) do
    %{data: render_one(e_role, ERoleView, "e_role.json")}
  end

  def render("e_role.json", %{e_role: e_role}) do
    %{
      id: e_role.id,
      capacity: e_role.capacity,
      vessle_id: e_role.vessle_id,
      drole_id: e_role.drole_id
    }
  end
end
