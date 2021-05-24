defmodule SpiderWeb.BusinessController do
  use SpiderWeb, :controller

  alias Spider.Businesses
  alias Spider.Businesses.Business
  alias Spider.Groups
  alias Spider.Groups.Group
  alias Spider.Repo
  alias Spider.BusinessToolKit

  action_fallback(SpiderWeb.FallbackController)

  def index(conn, _params) do
    businesses = Businesses.list_businesses() |> Repo.preload(:business_assets) |> Repo.preload(:user)
    render(conn, "index.json", businesses: businesses)
  end

  def get_businesses_using_user_id(conn, %{"user_id" => user_id}) do

    case Businesses.get_businesses_using_user_id(user_id) do
      {:empty, message} ->
        conn
        |> put_status(:ok)
        |> json(%{
          data: [],
          message: message
        })

      {:ok, businesses} ->

        businesses = businesses |> Repo.preload(:business_assets) |> Repo.preload(:user)

        conn
        |> render("index.json", businesses: businesses)
    end
    
  end

  def create(conn, %{"business" => business_params}) do

    with {:ok, %Business{} = business} <- Businesses.create_business(business_params) do

      group_params = %{
        user_id: business.user_id,
        business_id: business.id,
        status: 1,
        role: 1
      }
     
      Task.start(fn -> 

        if business.business_type in ["group_ranch", "association", "co-oparative"] do
          Groups.create_group(group_params)
        end

      end) 

      Task.start(fn -> 
        
        BusinessToolKit.create_default_asset(business)
        
      end)

      Task.start(fn -> 
      
        if business.sub_category in ["slaughter-house", "abattoir"] do
          Spider.SlaughterOrderBundlers.create_slaughter_order_bundler %{business_id: business.id}
        end

      end)

      Task.start(fn -> 
      
        if business.sub_category in ["export-zone"] do
          Spider.ExportZoneBundlers.create_export_zone_bundler %{business_id: business.id}
        end

      end)

      Task.start(fn ->
      
        if business.sub_category in ["feedlot"] do
          Spider.FeedLotBundlers.create_feed_lot_bundler(%{business_id: business.id})
        end

      end)

      conn
      |> put_status(:created)
      |> put_resp_header("location", business_path(conn, :show, business))
      |> render("show.json", business: business |> Repo.preload(:business_assets) |> Repo.preload(:user))

    end

  end

  def show(conn, %{"id" => id}) do

    business = Businesses.get_business!(id) |> Repo.preload(:business_assets) |> Repo.preload(:user)
    render(conn, "show.json", business: business)

  end

  def update(conn, %{"id" => id, "business" => business_params}) do

    business = Businesses.get_business!(id)

    with {:ok, %Business{} = business} <- Businesses.update_business(business, business_params) do
      render(conn, "show.json", business: business  |> Repo.preload(:business_assets) |> Repo.preload(:user))
    end

  end

  def delete(conn, %{"id" => id}) do

    business = Businesses.get_business!(id)

    with {:ok, %Business{}} <- Businesses.delete_business(business) do
      send_resp(conn, :no_content, "")
    end

  end
  
end
