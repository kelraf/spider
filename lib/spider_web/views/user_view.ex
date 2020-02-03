defmodule SpiderWeb.UserView do
  use SpiderWeb, :view
  alias SpiderWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      phone_number: user.phone_number,
      email: user.email,
      password_hash: user.password_hash,
      verification_code: user.verification_code,
      first_name: user.first_name,
      last_name: user.last_name,
      role: user.role,
      national_id_number: user.national_id_number,
      kra_pin: user.kra_pin}
  end
end
