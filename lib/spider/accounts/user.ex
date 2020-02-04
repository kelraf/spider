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
    field :password_hash, :string
    field :phone_number, :string
    field :role, :integer
    field :verification_code, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:phone_number, :email, :raw_password, :password_hash, :verification_code, :first_name, :last_name, :role, :national_id_number, :kra_pin])
    |> validate_required([:phone_number, :raw_password, :first_name, :last_name, :role])
    |> validate_length(:raw_password, min: 6, max: 15)
    |> validate_length(:phone_number, min: 10, max: 15)
    |> UserToolKit.validate_roles()
    |> UserToolKit.password_hash()
    |> UserToolKit.set_verification_code()
    |> unique_constraint(:phone_number)
    |> unique_constraint(:email)
    |> unique_constraint(:national_id_number)
  end
end
