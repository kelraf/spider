defmodule Spider.Produces.Produce do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business

  schema "produces" do
    field :quantity, :integer
    field :category, :string
    field :type, :string
    field :units, :string

    belongs_to(:user, User)
    belongs_to(:business, Business)

    timestamps()
  end

  @doc false
  def changeset(produce, attrs) do
    produce
    |> cast(attrs, [:type, :category, :quantity, :units, :user_id, :business_id])
    |> validate_required([:type, :category, :quantity, :units, :user_id, :business_id])
  end
end
