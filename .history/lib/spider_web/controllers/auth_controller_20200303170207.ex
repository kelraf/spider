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

        case Guardian.encode_and_sign(user) do
          {:ok, token, _claims} ->
            conn
            |> put_req_header("authorization", "Bearer #{token}")
            |> json(%{
              token: token
            })

          {:error, _reason} ->
            conn 
            |> json(%{
              error: "Oops Something went wrong. Please Try Again"
            })
        end

        
    end

  end
  
end
