defmodule SpiderWeb.BusinessAssetView do
  use SpiderWeb, :view
  alias SpiderWeb.BusinessAssetView

  def render("index.json", %{business_assets: business_assets}) do
    %{data: render_many(business_assets, BusinessAssetView, "business_asset.json")}
  end

  def render("show.json", %{business_asset: business_asset}) do
    %{data: render_one(business_asset, BusinessAssetView, "business_asset.json")}
  end

  def render("business_asset.json", %{business_asset: business_asset}) do
    %{
      id: business_asset.id,
      asset_name: business_asset.asset_name,
      business_id: business_asset.business_id,
      status: business_asset.status
    }
  end
end
