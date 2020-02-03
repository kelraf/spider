defmodule Spider.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :first_name, :string
    field :kra_pin, :string
    field :last_name, :string
    field :national_id_number, :integer
    field :password, :string, virtual: true
    field :password_hash, :string
    field :phone_number, :string
    field :role, :integer
    field :verification_code, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:phone_number, :email, :password_hash, :verification_code, :first_name, :last_name, :role, :national_id_number, :kra_pin])
    |> validate_required([:phone_number, :password_hash, :first_name, :last_name, :role])
    |> unique_constraint(:phone_number)
    |> unique_constraint(:email)
    |> unique_constraint(:national_id_number)
  end
end
