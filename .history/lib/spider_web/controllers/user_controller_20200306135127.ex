defmodule SpiderWeb.UserController do
  use SpiderWeb, :controller

  alias Spider.Accounts
  alias Spider.Accounts.User

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do

    phone_number = user_params["phone_number"]

    cond do

      byte_size(phone_number) < 10 ->
        conn
        |> json(%{
          errors: %{
            phone_number: ["Invalid Phone Number"]
          }
        })

      byte_size(phone_number) > 15 ->
        conn
        |> json(%{
          errors: %{
            phone_number: ["Invalid Phone Number"]
          }
        })

      true ->

        case user_params |> 

        with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", user_path(conn, :show, user))
          |> render("show.json", user: user)
        end

    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
