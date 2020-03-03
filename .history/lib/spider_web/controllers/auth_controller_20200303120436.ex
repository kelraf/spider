defmodule SpiderWeb.UserController do
  use SpiderWeb, :controller

  # alias Spider.Accounts
  # alias Spider.Accounts.User

  action_fallback SpiderWeb.FallbackController
  
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end
  
end