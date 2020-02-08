defmodule Spider.Businesses.Business do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.BusinessToolKit


  schema "businesses" do
    field :business_name, :string
    field :country_code, :string
    field :business_type, :string
    field :category, :string
    field :business_pin, :string
    field :location, :string
    field :registration_number, :string

    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:business_name, :business_pin, :registration_number, :business_type, :category, :user_id, :country_code, :location])
    |> validate_required([:business_name, :registration_number, :business_type, :category, :user_id, :country_code, :location])
    |> validate_length(:business_name, min: 2, max: 100)
    |> BusinessToolKit.validate_business_type()
    |> validate_length(:registration_number, min: 2)
    |> validate_length(:country_code, min: 2)
    |> validate_length(:location, min: 4)
    |> unique_constraint(:business_pin)
    |> unique_constraint(:registration_number)
  end
end
