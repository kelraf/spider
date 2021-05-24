defmodule SpiderWeb.AuthView do
    use SpiderWeb, :view
    alias SpiderWeb.AuthView
  
    alias SpiderWeb.AvatarView

    def render("index.json", %{users: users}) do
        %{data: render_many(users,  __MODULE__, "user.json")}
    end

    def render("show.json", %{user: user}) do
        %{data: render_one(user,  __MODULE__, "user.json")}
    end

    def render("user.json", %{user: user}) do
        %{
            # auth_status: user.auth_status,
            # auth_token: user.auth_token,
            id: user.id,
            phone_number: user.phone_number,
            email: user.email,
            password_hash: user.password_hash,
            first_name: user.first_name,
            last_name: user.last_name,
            role: user.role,
            status: user.status,
            national_id_number: user.national_id_number,
            pin: user.pin,
            country_name: user.country_name,
            country_calling_code: user.country_calling_code,
            currency: user.currency,
            currency_name: user.currency_name,
            continent_code: user.continent_code,
            latitude: user.latitude,
            longitude: user.longitude,
            # avatar: render_one(user.avatar, AvatarView, "avatar.json", as: :avatar),
            # business: render_one(user.business, __MODULE__, "business.json", as: :business)
        }
    end

    def render("business.json", %{business: business}) do
        %{
          id: business.id,
          business_name: business.business_name,
          business_pin: business.business_pin,
          registration_number: business.registration_number,
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
          longitude: business.longitude
        }
      end

  end