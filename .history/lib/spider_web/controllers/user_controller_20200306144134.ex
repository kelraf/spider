defmodule SpiderWeb.UserController do
  use SpiderWeb, :controller

  alias Spider.Accounts
  alias Spider.Accounts.User
  alias Spider.UserToolKit
  alias Spider.Sms
  alias Spider.VerificationAgentToolKit

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

        case user_params |> UserToolKit.get_user_by_phone true, 0 do
          {:ok, user} ->

            # Generate a random code and Send it in an sms
            code = Enum.random(2000..99999)
            phone_number = user_params["phone_number"]

            spider_code = %{
                code: code,
                created: NaiveDateTime.utc_now,
                status: 1
            }

            VerificationAgentToolKit.put VerificationAgentToolKit, phone_number, spider_code

            Task.start(fn -> 
                Process.sleep(90000);
                VerificationAgentToolKit.delete_one VerificationAgentToolKit, phone_number
            end)

            conn
            |> json(%{
              message: "It Seems Like you already have an account. Please Reply with the code sent to #{user_params["phone_number"]} to activate Your Account.",
              data: %{
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
                longitude: user.longitude
              }
            })

          {:error, _user} ->

            with {:ok, %User{} = user} <- Accounts.create_user(user_params) do

              # Generate a random code and Send it in an sms
              code = Enum.random(2000..99999)
              phone_number = user_params["phone_number"]

              spider_code = %{
                  code: code,
                  created: NaiveDateTime.utc_now,
                  status: 1
              }

              VerificationAgentToolKit.put VerificationAgentToolKit, phone_number, spider_code

              Task.start(fn -> 
                  Process.sleep(90000);
                  VerificationAgentToolKit.delete_one VerificationAgentToolKit, phone_number
              end)

              conn
              |> put_status(:created)
              |> put_resp_header("location", user_path(conn, :show, user))
              |> render("show.json", user: user)

            end
            
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
