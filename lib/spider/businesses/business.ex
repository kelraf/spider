defmodule Spider.Businesses.Business do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User


  schema "businesses" do
    field :business_name, :string
    field :country_code, :string
    field :county, :string
    field :business_type, :integer
    field :kra_pin, :string
    field :location, :string
    field :registration_number, :string
    field :sub_county, :string
    field :ward, :string

    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:business_name, :kra_pin, :registration_number, :business_type, :user_id, :country_code, :county, :sub_county, :ward, :location])
    |> validate_required([:business_name, :kra_pin, :registration_number, :business_type, :user_id, :country_code, :county, :sub_county, :ward, :location])
    |> validate_length(:business_name, min: 1, max: 100)
    |> validate_length(:kra_pin, min: 4)
    |> validate_length(:registration_number, min: 2)
    |> validate_length(:country_code, min: 2)
    |> validate_length(:county, min: 2)
    |> validate_length(:sub_county, min: 2)
    |> validate_length(:ward, min: 2)
    |> validate_length(:location, min: 4)
    |> unique_constraint(:kra_pin)
    |> unique_constraint(:registration_number)
  end
end
