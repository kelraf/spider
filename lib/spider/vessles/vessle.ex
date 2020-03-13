defmodule Spider.Vessles.Vessle do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business

  schema "vessles" do
    field :role, :string
    field :unique_number, :string

    belongs_to(:user, User)
    belongs_to(:business, Business)

    timestamps()
  end

  @doc false
  def changeset(vessle, attrs) do
    vessle
    |> cast(attrs, [:unique_number, :role, :user_id, :business_id])
    |> validate_required([:unique_number, :role, :user_id, :business_id])
    |> unique_constraint(:unique_number)
  end
end
