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

  pipeline :jwt_auth do
    plug(Spider.Guardian.AuthPipeline)
  end

  scope "/", SpiderWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", SpiderWeb do
    
    pipe_through :api
    pipe_through :jwt_auth

    # Verification Starts
    post "/verification", VerificationController, :sms_sender

    # Verification ends
    resources "/users", UserController

    # Business Routes
    resources "/businesses", BusinessController
    get "/businesses/user/:user_id", BusinessController, :get_businesses_using_user_id

    # End of business routes

    # Transtools Routes

    resources "/transtools", TranstoolController
    get "/transtools/business/:business_id", TranstoolController, :get_transtool_using_business_id

    # Transtools Routes End
    resources "/transtooluserrels", TranstoolUserRelController
    resources "/livestocks", LivestockController
    resources "/produces", ProduceController
    resources "/products", ProductController
    resources "/groups", GroupController

  end
  
end
