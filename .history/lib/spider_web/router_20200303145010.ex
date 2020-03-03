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

    # Verification Starts
    post "/verification", VerificationController, :sms_sender
    # Verification ends

    # Users Starts
    resources "/users", UserController
    post "/users", UserController, :create
    get "/users", UserController, :index # Belongs to Admins
    get "/users/:id", UserController, :show
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete
    # Users Ends

    # Business Routes
    post "/businesses", BusinessController, :create
    get "/businesses", BusinessController, :index # Belongs to Admins
    get "/businesses/:id", BusinessController, :show
    put "/businesses/:id", BusinessController, :update
    delete "/businesses/:id", BusinessController, :delete
    get "/businesses/user/:user_id", BusinessController, :get_businesses_using_user_id
    # End of business routes

    # Transtools Routes
    # resources "/transtools", TranstoolController
    post "/transtools", TranstoolController, :create
    get "/transtools", TranstoolController, :index # Belongs to admins
    get "/transtools/:id", TranstoolController, :show
    put "/transtools/:id", TranstoolController, :update
    delete "/transtools/:id", TranstoolController, :delete
    get "/transtools/business/:business_id", TranstoolController, :get_transtool_using_business_id
    # Transtools Routes End
    
    resources "/transtooluserrels", TranstoolUserRelController
    resources "/livestocks", LivestockController
    resources "/produces", ProduceController
    resources "/products", ProductController
    resources "/groups", GroupController

  end
  
end