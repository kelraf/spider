defmodule SpiderWeb.BusinessView do
  use SpiderWeb, :view
  alias SpiderWeb.BusinessView
  alias SpiderWeb.BusinessAssetView

  def render("index.json", %{businesses: businesses}) do
    %{data: render_many(businesses, BusinessView, "business.json")}
  end

  def render("show.json", %{business: business}) do
    %{data: render_one(business, BusinessView, "business.json")}
  end

  def render("business.json", %{business: business}) do
    %{
      id: business.id,
      business_name: business.business_name,
      business_pin: business.business_pin,
      registration_number: business.registration_number,
      business_type: business.business_type,
      category: business.category,
      user_id: business.user_id,
      country_name: business.country_name,
      country_calling_code: business.country_calling_code,
      currency: business.currency,
      currency_name: business.currency_name,
      continent_code: business.continent_code,
      latitude: business.latitude,
      longitude: business.longitude,
      business_assets: render_many(business.business_assets, BusinessAssetView, "business_asset.json", as: :business_asset),
      user: render_one(business.user, BusinessView, "user.json", as: :user)
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      phone_number: user.phone_number,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      role: user.role,
      status: user.status,
      country_name: user.country_name,
      country_calling_code: user.country_calling_code,
      currency: user.currency,
      currency_name: user.currency_name,
      continent_code: user.continent_code,
      latitude: user.latitude,
      longitude: user.longitude
    }
  end

end
