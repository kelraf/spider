defmodule SpiderWeb.LivestockView do
  use SpiderWeb, :view
  alias SpiderWeb.LivestockView
  alias SpiderWeb.TLivestockView

  def render("index.json", %{livestocks: livestocks}) do
    %{data: render_many(livestocks, LivestockView, "livestock.json")}
  end

  def render("show.json", %{livestock: livestock}) do
    %{data: render_one(livestock, LivestockView, "livestock.json")}
  end

  def render("livestock.json", %{livestock: livestock}) do
    %{
      id: livestock.id,
      d_livestock_id: livestock.d_livestock_id,
      quantity: livestock.quantity,
      price: livestock.price,
      user_id: livestock.user_id,
      business_id: livestock.business_id,
      tlivestocks: render_many(livestock.tlivestocks, TLivestockView, "t_livestock.json", as: :t_livestock),
      business: render_one(livestock.business, __MODULE__, "business.json", as: :business)
    }
  end

  def render("business.json", %{business: business}) do
    %{
      id: business.id,
      business_name: business.business_name,
      business_type: business.business_type,
      category: business.category,
      sub_category: business.sub_category,
      user_id: business.user_id,
      country_name: business.country_name,
      country_calling_code: business.country_calling_code,
      currency: business.currency,
      currency_name: business.currency_name,
      continent_code: business.continent_code,
      latitude: business.latitude,
      longitude: business.longitude,
    }
  end

end
