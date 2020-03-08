defmodule SpiderWeb.AuthController do
  use SpiderWeb, :controller

  # alias Spider.Accounts
  # alias Spider.Accounts.User

  action_fallback SpiderWeb.FallbackController
  
  def login(conn, %{"credentials" => user_credentials}) do
    
  end
  
end
