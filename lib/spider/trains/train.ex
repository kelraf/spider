defmodule Spider.Trains.Train do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business


  schema "trains" do
    field :role, :string
    field :unique_number, :string

    belongs_to(:user, User)
    belongs_to(:business, Business)

    timestamps()
  end

  @doc false
  def changeset(train, attrs) do
    train
    |> cast(attrs, [:unique_number, :role, :user_id, :business_id])
    |> validate_required([:unique_number, :role, :user_id, :business_id])
    |> unique_constraint(:unique_number)
  end
end
