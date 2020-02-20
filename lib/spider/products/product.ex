defmodule Spider.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business


  schema "products" do
    field :category, :string
    field :name, :string
    field :quantity, :integer
    field :type, :string
    field :units, :string

    belongs_to(:user, User)
    belongs_to(:business, Business)

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :type, :category, :quantity, :units, :user_id, :business_id])
    |> validate_required([:name, :type, :category, :quantity, :units, :user_id, :business_id])
  end
end