defmodule SpiderWeb.BusinessAssetController do
  use SpiderWeb, :controller

  alias Spider.BusinessAssets
  alias Spider.BusinessAssets.BusinessAsset

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    business_assets = BusinessAssets.list_business_assets()
    render(conn, "index.json", business_assets: business_assets)
  end

  def get_business_assets_using_business_id(conn, %{"id" => id}) do
    
    case BusinessAssets.get_business_assets_using_business_id(id) do
      {:empty, _nonses} ->
        conn
        |> put_status(:not_found)
        |> json(%{
          message: "No Business Assets Related To Your Business"
        })

      {:ok, business_assets} ->
        conn
        |> put_status(:ok)
        |> render("index.json", business_assets: business_assets)
        
    end

  end

  def create(conn, %{"business_asset" => business_asset_params}) do
    with {:ok, %BusinessAsset{} = business_asset} <- BusinessAssets.create_business_asset(business_asset_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", business_asset_path(conn, :show, business_asset))
      |> render("show.json", business_asset: business_asset)
    end
  end

  def show(conn, %{"id" => id}) do
    business_asset = BusinessAssets.get_business_asset!(id)
    render(conn, "show.json", business_asset: business_asset)
  end

  def update(conn, %{"id" => id, "business_asset" => business_asset_params}) do
    business_asset = BusinessAssets.get_business_asset!(id)

    with {:ok, %BusinessAsset{} = business_asset} <- BusinessAssets.update_business_asset(business_asset, business_asset_params) do
      render(conn, "show.json", business_asset: business_asset)
    end
  end

  def delete(conn, %{"id" => id}) do
    business_asset = BusinessAssets.get_business_asset!(id)
    with {:ok, %BusinessAsset{}} <- BusinessAssets.delete_business_asset(business_asset) do
      send_resp(conn, :no_content, "")
    end
  end
end
