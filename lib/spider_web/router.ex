defmodule SpiderWeb.Router do
  use SpiderWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpiderWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", SpiderWeb do
    
    pipe_through :api

    # Verification Starts
    post "/verification", VerificationController, :sms_sender

    # Verification ends

    resources "/users", UserController
    resources "/businesses", BusinessController

  end
  
end
