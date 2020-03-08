defmodule SpiderWeb.UserController do
  use SpiderWeb, :controller

  # alias Spider.Accounts
  # alias Spider.Accounts.User

  action_fallback SpiderWeb.FallbackController
  
  def create(conn, %{"credentials" => user_params}) do
    
  end
  
end
