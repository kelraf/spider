defmodule SpiderWeb.AuthController do
  use SpiderWeb, :controller

  alias Spider.Auth

  action_fallback SpiderWeb.FallbackController
  
  def login(conn, %{"credentials" => user_credentials}) do
    
    case Auth.login(user_credentials) do
      {:error, message} ->
        
    end

  end
  
end
