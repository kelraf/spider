defmodule SpiderWeb.TRoleView do
  use SpiderWeb, :view
  alias SpiderWeb.TRoleView

  def render("index.json", %{troles: troles}) do
    %{data: render_many(troles, TRoleView, "t_role.json")}
  end

  def render("show.json", %{t_role: t_role}) do
    %{data: render_one(t_role, TRoleView, "t_role.json")}
  end

  def render("t_role.json", %{t_role: t_role}) do
    %{
      id: t_role.id,
      capacity: t_role.capacity,
      train_id: t_role.train_id,
      drole_id: t_role.drole_id
    }
  end
end
