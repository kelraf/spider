defmodule SpiderWeb.AuthController do
  use SpiderWeb, :controller

  alias Spider.Auth

  action_fallback SpiderWeb.FallbackController
  
  def login(conn, %{"user_credentials" => user_credentials}) do
    
    case Auth.login(user_credentials) do
      {:error, message} ->
        conn
        |> json(%{
          message: message
        })

      {:ok, user} ->
        user = Map.from_struct(user)
        user_data_to_encode = %{
          id: user.id,
          role: user.role,
          email: user.email,
          phone_number: user.phone_number
        }
        conn 
        |> json(user_data_to_encode)
    end

  end
  
end
