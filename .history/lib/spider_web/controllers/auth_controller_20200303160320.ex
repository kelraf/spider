defmodule SpiderWeb.AuthController do
  use SpiderWeb, :controller

  alias Spider.Auth

  action_fallback SpiderWeb.FallbackController
  
  def login(conn, %{"user_credentials" => user_credentials}) do
    
    case Auth.login(user_credentials) do
      {:error, message} ->
        json(%{
          message: message
        })

      {:ok, user} ->
        user = Map.from_struct(user)
        json(conn, user)
    end

  end
  
end
