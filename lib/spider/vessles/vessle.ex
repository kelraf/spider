defmodule Spider.Vessles.Vessle do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.ERoles.ERole

  schema "vessles" do
    field :unique_number, :string
    field :status, :string, default: "available"

    belongs_to(:user, User)
    belongs_to(:business, Business)

    has_many(:eroles, ERole)

    timestamps()
  end

  @doc false
  def changeset(vessle, attrs) do
    vessle
    |> cast(attrs, [:unique_number, :user_id, :status, :business_id])
    |> validate_required([:unique_number, :user_id, :status, :business_id])
    |> unique_constraint(:unique_number)
  end
end
