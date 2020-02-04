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
    %{id: business.id,
      business_name: business.business_name,
      kra_pin: business.kra_pin,
      registration_number: business.registration_number,
      country_code: business.country_code,
      county: business.county,
      sub_county: business.sub_county,
      ward: business.ward,
      location: business.location}
  end
end
