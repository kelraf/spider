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
        conn 
        |> json(user)
      IO.inspect user_credentials
    end

  end
  
end
