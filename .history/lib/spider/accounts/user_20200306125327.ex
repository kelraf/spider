defmodule Spider.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.UserToolKit
  alias Spider.BusinessToolKit

  schema "users" do
    field(:email, :string)
    field(:first_name, :string)
    field(:pin, :string)
    field(:last_name, :string)
    field(:national_id_number, :integer)
    field(:raw_password, :string, virtual: true)
    field(:confirm_password, :string, virtual: true)
    field(:password_hash, :string)
    field(:phone_number, :string)
    field(:role, :string)
    field(:status, :integer, default: 0)
    field(:country_name, :string)
    field(:currency, :string)
    field(:currency_name, :string)
    field(:continent_code, :string)
    field(:country_calling_code, :string)
    field(:latitude, :string)
    field(:longitude, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :phone_number,
      :email,
      :raw_password,
      :confirm_password,
      :password_hash,
      :first_name,
      :last_name,
      :role,
      :status,
      :national_id_number,
      :pin,
      :country_calling_code,
      :country_name,
      :currency,
      :currency_name,
      :continent_code,
      :latitude,
      :longitude
    ])
    |> validate_required([
      :phone_number,
      :raw_password,
      :confirm_password,
      :first_name,
      :last_name,
      :pin,
      :role,
      :status
    ])
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
