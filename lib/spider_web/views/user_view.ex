defmodule SpiderWeb.UserView do
  use SpiderWeb, :view
  alias SpiderWeb.UserView
  alias SpiderWeb.AvatarView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      phone_number: user.phone_number,
      email: user.email,
      password_hash: user.password_hash,
      first_name: user.first_name,
      last_name: user.last_name,
      role: user.role,
      status: user.status,
      national_id_number: user.national_id_number,
      pin: user.pin,
      country_name: user.country_name,
      country_calling_code: user.country_calling_code,
      currency: user.currency,
      currency_name: user.currency_name,
      continent_code: user.continent_code,
      latitude: user.latitude,
      longitude: user.longitude,
      avatar: render_one(user.avatar, AvatarView, "avatar.json", as: :avatar)
    }
  end
end
