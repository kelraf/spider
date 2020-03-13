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
    post "/auth/login", AuthController, :login
    # Auth Ends

    # Verification Starts
    post "/auth/send/code", VerificationController, :sms_sender
    post "/auth/verify/code", VerificationController, :verify_code
    # Verification ends

    # Users Start
    post "/users", UserController, :create
    # Users Ends

  end

  # Other scopes may use custom stacks.
  scope "/api", SpiderWeb do
    
    pipe_through [:api]

    # Users Starts
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
    
    # Groups Routes
    resources "/groups", GroupController
    # Groups Routes End

    # Vehicles Routes
    post "/vehicles", VehicleController, :create
    get "/vehicles", VehicleController, :index
    get "/vehicles/:id", VehicleController, :show
    get "/vehicles/business/:business_id", VehicleController, :get_vehicles_using_business_id
    put "/vehicles/:id", VehicleController, :update
    delete "/vehicles/:id", VehicleController, :delete
    # Vehicles Routes End

    # Trains Routes
    post "/trains", TrainController, :create
    get "/trains", TrainController, :index # Belongs Admins
    get "/trains/:id", TrainController, :show
    get "/trains/business/:business_id", TrainController, :get_trains_using_business_id
    put "/trains/:id", TrainController, :update
    delete "/trains/:id", TrainController, :delete
    # Trains Routes End

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

  end
  
end
