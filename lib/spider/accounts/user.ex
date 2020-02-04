defmodule Spider.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.UserToolKit


  schema "users" do
    
    field :email, :string
    field :first_name, :string
    field :kra_pin, :string
    field :last_name, :string
    field :national_id_number, :integer
    field :raw_password, :string, virtual: true
    field :confirm_password, :string, virtual: true
    field :password_hash, :string
    field :phone_number, :string
    field :role, :integer
    field :country_code, :string
    field :county, :string
    field :sub_county, :string
    field :ward, :string
    field :location, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:phone_number, :email, :raw_password, :confirm_password, :password_hash, :first_name, :last_name, :role, :national_id_number, :kra_pin, :country_code, :county, :sub_county, :ward, :location])
    |> validate_required([:phone_number, :raw_password, :confirm_password, :first_name, :last_name, :role])
    |> validate_length(:raw_password, min: 6, max: 15)
    |> validate_length(:phone_number, min: 10, max: 15)
    |> UserToolKit.validate_roles()
    |> UserToolKit.password_confirm()
    |> UserToolKit.password_hash()
    |> unique_constraint(:phone_number)
    |> unique_constraint(:email)
    |> unique_constraint(:national_id_number)
  end
end
