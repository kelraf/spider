defmodule Spider.Livestocks.Livestock do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business


  schema "livestocks" do

    field :category, :string
    field :quantity, :integer
    field :type, :string

    belongs_to(:user, User)
    belongs_to(:business, Business)

    timestamps()
  end

  @doc false
  def changeset(livestock, attrs) do
    livestock
    |> cast(attrs, [:type, :category, :quantity, :user_id, :business_id])
    |> validate_required([:type, :category, :quantity, :user_id, :business_id])
  end
end
