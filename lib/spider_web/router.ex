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

    # LiveStocks Order Container Routes
    post "/livestock-order-containers", LivestockOrderContainerController, :create
    get "/livestock-order-containers", LivestockOrderContainerController, :index # Belongs to Admins
    get "/livestock-order-containers/:id", LivestockOrderContainerController, :show 
    # get "/livestock-order-containers/business/:business_id", LivestockOrderContainerController, :get_order_container_using_business_id
    put "/livestock-order-containers/:id", LivestockOrderContainerController, :update
    delete "/livestock-order-containers/:id", LivestockOrderContainerController, :delete 
    # LiveStocks Order Container Rounts End

    # LiveStocks Orders Routes
    post "/livestock-orders", LivestockOrderController, :create
    get "/livestock-orders", LivestockOrderController, :index # Belongs to Admins
    get "/livestock-orders/:id", LivestockOrderController, :show 
    put "/livestock-orders/:id", LivestockOrderController, :update
    delete "/livestock-orders/:id", LivestockOrderController, :delete 
    # LiveStocks Orders Rounts End

    # Center Orders Routes
    post "/center-orders", CenterOrderController, :create
    get "/center-orders", CenterOrderController, :index # Belongs to Admins
    get "/center-orders/:id", CenterOrderController, :show 
    put "/center-orders/:id", CenterOrderController, :update
    delete "/center-orders/:id", CenterOrderController, :delete 
    # Center Orders Rounts End

    # Center Orders Routes
    post "/livestock-sales", LivestockSaleController, :create
    get "/livestock-sales", LivestockSaleController, :index # Belongs to Admins
    get "/livestock-sales/:id", LivestockSaleController, :show 
    put "/livestock-sales/:id", LivestockSaleController, :update
    delete "/livestock-sales/:id", LivestockSaleController, :delete 
    # Center Orders Rounts End

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

    # Defined LiveStock
    post "/d-livestock", DLivestockController, :create
    get "/d-livestock", DLivestockController, :index
    get "/d-livestock/:id", DLivestockController, :show
    put "/d-livestock/:id", DLivestockController, :update
    delete "/d-livestock/:id", DLivestockController, :delete
    # End Defined LiveStock

    # Defined LiveStock
    post "/d-livestock-images", DlivestockImageController, :create
    get "/d-livestock-images", DlivestockImageController, :index
    get "/d-livestock-images/:id", DlivestockImageController, :show
    put "/d-livestock-images/:id", DLlvestockImageController, :update
    delete "/d-livestock-images/:id", DlivestockImageController, :delete
    # End Defined LiveStock

    # Livestock Routes
    post "/livestocks", LivestockController, :create
    get "/livestocks", LivestockController, :index
    get "/livestocks/:id", LivestockController, :show
    get "/livestocks/business/:business_id", LivestockController, :get_livestocks_using_business_id
    delete "/livestocks/:id", LivestockController, :delete
    put "/livestocks/:id", LivestockController, :update
    # Livestock Routes End

    # Produces Routes
    post "/produces", ProduceController, :create
    get "/produces", ProduceController, :index
    get "/produces/:id", ProduceController, :show
    get "/produces/business/:business_id", ProduceController, :get_produces_using_business_id
    put "/produces/:id", ProduceController, :update
    # Produces Routes End

    # Defined Produce
    post "/d-produces", DProduceController, :create
    get "/d-produces", DProduceController, :index
    get "/d-produces/:id", DProduceController, :show
    put "/d-produces/:id", DProduceController, :update
    delete "/d-produces/:id", DProduceController, :delete
    # End Defined Produce

    # Products Router
    post "/products", ProductController, :create
    get "/products", ProductController, :index
    get "/products/:id", ProductController, :show
    put "/products/:id", ProductController, :update
    get "/products/business/:business_id", ProductController, :get_products_using_business_id
    # Products Routers Ends

    # Product Images Container
    post "/products-images-containers", ProductImagesContainerController, :create
    get "/products-images-containers", ProductImagesContainerController, :index
    get "/products-images-containers/:id", ProductImagesContainerController, :show
    put "/products-images-containers/:id", ProductImagesContainerController, :update
    delete "/products-images-containers/:id", ProductImagesContainerController, :delete
    # Product Images Container

    # Product Images
    post "/products-images", ProductImageController, :create
    get "/products-images", ProductImageController, :index
    get "/products-images/:id", ProductImageController, :show
    put "/products-images/:id", ProductImageController, :update
    delete "/products-images/:id", ProductImageController, :delete
    # Product Images

    # Defined Roles i.e DRoles
    post "/d-roles", DRoleController, :create
    get "/d-roles", DRoleController, :index
    get "/d-roles/:id", DRoleController, :show
    # End of Defined Roles

    # Vehicle Roles i.e VRole
    post "/v-roles", VRoleController, :create
    get "/v-roles", VRoleController, :index
    get "/v-roles/:id", VRoleController, :show
    put "/v-roles/:id", VRoleController, :update
    delete "/v-roles/:id", VRoleController, :delete
    # End Vehicle Roles

    # Vessles Roles i.e ERole
    post "/e-roles", ERoleController, :create
    get "/e-roles", ERoleController, :index
    get "/e-roles/:id", ERoleController, :show
    put "/e-roles/:id", ERoleController, :update
    delete "/e-roles/:id", ERoleController, :delete
    # End Vessles Roles

     # Train Roles i.e TRole
     post "/t-roles", TRoleController, :create
     get "/t-roles", TRoleController, :index
     get "/t-roles/:id", TRoleController, :show
     put "/t-roles/:id", TRoleController, :update
     delete "/t-roles/:id", TRoleController, :delete
     # End Train Roles

     # Flight Roles i.e FRole
     post "/f-roles", FroleController, :create
     get "/f-roles", FroleController, :index
     get "/f-roles/:id", FroleController, :show
     put "/f-roles/:id", FroleController, :update
     delete "/f-roles/:id", FroleController, :delete
     # End Flight Roles

     # Image Uploads
     post "/image-uploads", ImageUploadController, :create
     get "/image-uploads", ImageUploadController, :index
     get "/image-uploads/:id", ImageUploadController, :show
     put "/image-uploads/:id", ImageUploadController, :update
     delete "/image-uploads/:id", ImageUploadController, :delete
     # End Image Uploads

     # Avatars 
     post "/avatars", AvatarController, :create
     get "/avatars", AvatarController, :index
     get "/avatars/:id", AvatarController, :show
     put "/avatars/:id", AvatarController, :update
     delete "/avatars/:id", AvatarController, :delete
     # End Avatars

  end
  
end
