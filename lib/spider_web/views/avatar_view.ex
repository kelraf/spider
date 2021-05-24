defmodule SpiderWeb.AvatarView do
  use SpiderWeb, :view
  alias SpiderWeb.AvatarView

  def render("index.json", %{avatars: avatars}) do
    %{data: render_many(avatars, AvatarView, "avatar.json")}
  end

  def render("show.json", %{avatar: avatar}) do
    %{data: render_one(avatar, AvatarView, "avatar.json")}
  end

  def render("avatar.json", %{avatar: avatar}) do
    %{
      id: avatar.id,
      avatar: avatar.avatar,
      uuid: avatar.uuid,
      user_id: avatar.user_id
    }
  end
end
