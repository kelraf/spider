defmodule SpiderWeb.AuthController do
  use SpiderWeb, :controller

  alias Spider.Auth
  alias Spider.Guardian

  action_fallback SpiderWeb.FallbackController
  
  def login(conn, %{"user_credentials" => user_credentials}) do
    
    case Auth.login(user_credentials) do
      {:error, message} ->
        conn
        |> json(%{
          message: message
        })

      {:ok, user} ->
        token = Guardian.encode_and_sign(user)
        conn 
        |> json(%{
          token: token
        })
    end

  end
  
end
