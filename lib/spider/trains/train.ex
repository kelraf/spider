defmodule Spider.Trains.Train do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.TRoles.TRole


  schema "trains" do
    field :unique_number, :string
    field :status, :string, default: "available"

    belongs_to(:user, User)
    belongs_to(:business, Business)

    has_many(:troles, TRole)

    timestamps()
  end

  @doc false
  def changeset(train, attrs) do
    train
    |> cast(attrs, [:unique_number, :status, :user_id, :business_id])
    |> validate_required([:unique_number, :status, :user_id, :business_id])
    |> unique_constraint(:unique_number)
  end
end
