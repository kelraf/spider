defmodule SpiderWeb.GroupView do
  use SpiderWeb, :view
  alias SpiderWeb.GroupView

  def render("index.json", %{groups: groups}) do
    %{data: render_many(groups, GroupView, "group.json")}
  end

  def render("show.json", %{group: group}) do
    %{data: render_one(group, GroupView, "group.json")}
  end

  def render("group.json", %{group: group}) do
    %{id: group.id,
      user_id: group.user_id,
      business_id: group.business_id,
      status: group.status}
  end

  def render("group.json", %{group: group}) do
    %{
      id: group.id,
      user_id: group.user_id,
      business_id: group.business_id,
      status: group.status
    }
  end
end
