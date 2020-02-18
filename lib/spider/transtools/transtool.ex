defmodule Spider.Transtools.Transtool do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.TranstoolKit


  schema "transtools" do

    field :brand, :string
    field :model, :string
    field :registration_number, :string
    field :role, :string


    belongs_to(:user, User)
    belongs_to(:business, Business)

    timestamps()
  end

  @doc false
  def changeset(transtool, attrs) do
    transtool
    |> cast(attrs, [:registration_number, :brand, :model, :role, :user_id, :business_id])
    |> validate_required([:registration_number, :brand, :model, :role, :user_id, :business_id])
    |> TranstoolKit.validate_role()
    |> unique_constraint(:registration_number)
  end
end
