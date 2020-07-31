defmodule Spider.Businesses.Business do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.BusinessToolKit
  alias Spider.BusinessAssets.BusinessAsset

  schema "businesses" do
    field(:business_name, :string)
    field(:business_type, :string)
    field(:category, :string)
    field(:sub_category, :string)
    field(:business_pin, :string)
    field(:registration_number, :string)
    field(:country_name, :string)
    field(:currency, :string)
    field(:currency_name, :string)
    field(:continent_code, :string)
    field(:country_calling_code, :string)
    field(:latitude, :string)
    field(:longitude, :string)
    field(:exception, :boolean, virtual: true)

    belongs_to(:user, User)
    has_many(:business_assets, BusinessAsset)

    timestamps()
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [
      :business_name,
      :business_pin,
      :registration_number,
      :business_type,
      :sub_category,
      :category,
      :user_id,
      :country_calling_code,
      :country_name,
      :currency,
      :currency_name,
      :continent_code,
      :latitude,
      :longitude,
      :exception
    ])
    |> BusinessToolKit.validate_business_type()
    |> BusinessToolKit.validate_and_add_business_reg_number()
    |> validate_required([
      :business_name,
      :registration_number,
      :business_type,
      :category,
      :sub_category,
      :user_id
    ])
    |> validate_length(:business_name, min: 2, max: 100)
    |> BusinessToolKit.validate_business_sub_category()
    |> BusinessToolKit.validate_business_category()
    |> validate_length(:registration_number, min: 2)
    |> unique_constraint(:business_pin)
    |> unique_constraint(:registration_number)
  end
end
