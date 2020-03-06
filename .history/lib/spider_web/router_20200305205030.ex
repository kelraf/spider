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

  scope "/api", SpiderWeb do
    pipe_through :api

    # Auth Starts
    post "/user/auth", AuthController, :login
    # Auth Ends

    # Verification Starts
    post "/auth/send/code", VerificationController, :sms_sender
    post "/auth/verify/code", VerificationController, :sms_sender
    # Verification ends

    # Users Start
    post "/users", UserController, :create
    # Users Ends

  end

  # Other scopes may use custom stacks.
  scope "/api", SpiderWeb do
    
    pipe_through [:api, :jwt_auth]

    # Users Starts
    # resources "/users", UserController
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
    post "/transtools", TranstoolController, :create
    get "/transtools", TranstoolController, :index # Belongs to admins
    get "/transtools/:id", TranstoolController, :show
    put "/transtools/:id", TranstoolController, :update
    delete "/transtools/:id", TranstoolController, :delete
    get "/transtools/business/:business_id", TranstoolController, :get_transtool_using_business_id
    # Transtools Routes End

    # transtooluserrels Routes Starts
    post "/transtooluserrels", TranstoolUserRelController, :create
    get "/transtooluserrels", TranstoolUserRelController, :index
    get "/transtooluserrels/:id", TranstoolUserRelController, :show
    put "/transtooluserrels/:id", TranstoolUserRelController, :update
    delete "/transtooluserrels/:id", TranstoolUserRelController, :delete
    # transtooluserrels Routes End

    resources "/livestocks", LivestockController
    resources "/produces", ProduceController
    resources "/products", ProductController
    resources "/groups", GroupController

  end
  
end
