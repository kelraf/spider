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
    post "/auth/verify/code/:id", VerificationController, :verify_code
    # Verification ends

    # Users Start
    post "/users", UserController, :create
    # Users Ends

  end

  # Other scopes may use custom stacks.
  scope "/api", SpiderWeb do
    
    # pipe_through [:api, :jwt_auth]
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

    # Business Assets Routes
    post "/business-assets", BusinessAssetController, :create
    get "/business-assets", BusinessAssetController, :index
    get "/business-assets/:id", BusinessAssetController, :show
    put "/business-assets/:id", BusinessAssetController, :update
    get "/business-assets/business/:id", BusinessAssetController, :get_business_assets_using_business_id
    delete "/business-assets/:id", BusinessAssetController, :delete
    # Business Assets Routes Ends
    
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

    # Vessle Router
    post "/vessles", VessleController, :create
    get "/vessles", VessleController, :index # Belongs to Admins
    get "/vessles/:id", VessleController, :show
    get "/vessles/business/:business_id", VessleController, :get_vessles_using_business_id
    put "/vessles/:id", VessleController, :update
    delete "/vessles/:id", VessleController, :delete
    # Vessle Router End

    # Flight Routes
    post "/flights", FlightController, :create
    get "/flights", FlightController, :index # Belongs to admins
    get "/flights/:id", FlightController, :show
    get "/flights/business/:business_id", FlightController, :get_flights_using_business_id
    put "/flights/:id", FlightController, :update
    delete "/flights/:id", FlightController, :delete
    # Flight Routes End

    # Transporter Container Routes
    post "/transporter-containers", TransporterContainerController, :create
    get "/transporter-containers", TransporterContainerController, :index # Belongs to admins
    get "/transporter-containers/:id", TransporterContainerController, :show
    get "/transporter-containers/business/:business_id", TransporterContainerController, :get_transporter_containers_using_business_id
    put "/transporter-containers/:id", TransporterContainerController, :update
    delete "/transporter-containers/:id", TransporterContainerController, :delete
    # Transporter Container Routes End

    # Transporter Routes
    post "/transporters", TransporterController, :create
    get "/transporters", TransporterController, :index
    get "/transporters/:id", TransporterController, :show
    get "/transporters/transporter-container/:transporter_container_id", TransporterController, :get_transporters_using_transporter_container_id
    put "/transporters/:id", TransporterController, :update
    delete "/transporters/:id", TransporterController, :delete
    # Transporter Routes End

    # Order Container Routes
    post "/order-containers", OrderContainerController, :create
    get "/order-containers", OrderContainerController, :index # Belongs to Admins
    get "/order-containers/:id", OrderContainerController, :show 
    get "/order-containers/business/:business_id", OrderContainerController, :get_order_container_using_business_id
    put "/order-containers/:id", OrderContainerController, :update
    delete "/order-containers/:id", OrderContainerController, :delete 
    # Order Container Rounts End

    # Transtools Routes
    post "/transtools", TranstoolController, :create
    get "/transtools", TranstoolController, :index # Belongs to admins
    get "/transtools/:id", TranstoolController, :show
    get "/transtools/business/:business_id", TranstoolController, :get_transtool_using_business_id
    put "/transtools/:id", TranstoolController, :update
    delete "/transtools/:id", TranstoolController, :delete
    # Transtools Routes End

    # transtooluserrels Routes Starts
    post "/transtooluserrels", TranstoolUserRelController, :create
    get "/transtooluserrels", TranstoolUserRelController, :index
    get "/transtooluserrels/:id", TranstoolUserRelController, :show
    put "/transtooluserrels/:id", TranstoolUserRelController, :update
    delete "/transtooluserrels/:id", TranstoolUserRelController, :delete
    # transtooluserrels Routes End

    # Livestock Routes
    post "/livestocks", LivestockController, :create
    get "/livestocks", LivestockController, :index
    get "/livestocks/:id", LivestockController, :show
    get "/livestocks/business/:business_id", LivestockController, :get_livestocks_using_business_id
    put "/livestocks/:id", LivestockController, :update
    # Livestock Routes End

    # Produces Routes
    # resources "/produces", ProduceController
    post "/produces", ProduceController, :create
    get "/produces", ProduceController, :index
    get "/produces/:id", ProduceController, :show
    get "/produces/business/:business_id", ProduceController, :get_produces_using_business_id
    put "/produces/:id", ProduceController, :update
    # Produces Routes End

    # Products Router
    # resources "/products", ProductController
    post "/products", ProductController, :create
    get "/products", ProductController, :index
    get "/products/:id", ProductController, :show
    put "/products/:id", ProductController, :update
    # Products Routers Ends
  end
  
end
