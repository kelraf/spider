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
          message: message,
          status: "auth_error"
        })

      {:not_verified, message} ->

        conn
        |> json(%{
          message: message,
          status: "not_verified"
        })

      {:ok, user} ->

        case Guardian.encode_and_sign(user) do
          {:ok, token, _claims} ->
            conn
            |> put_req_header("authorization", "Bearer #{token}")
            |> json(%{
              status: "success",
              token: token
            })

          {:error, _reason} ->
            conn
            |> json(%{
              status: "gen_token_error",
              error: "Oops Something went wrong. Please Try Again"
            })
        end

        
    end

  end
  
end
