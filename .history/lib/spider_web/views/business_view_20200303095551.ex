defmodule SpiderWeb.BusinessView do
  use SpiderWeb, :view
  alias SpiderWeb.BusinessView

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
      country_code: business.country_code,
      business_type: business.business_type,
      category: business.category,
      user_id: business.user_id,
      country_name: business.country_name,
      country_calling_code: business.country_calling_code,
      currency: business.currency,
      currency_name: business.currency_name,
      continent_code: business.continent_code,
      latitude: business.latitude,
      longitude: business.longitude
    }
  end
end
