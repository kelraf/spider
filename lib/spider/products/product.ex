defmodule Spider.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.ProductImagesContainers.ProductImagesContainer


  schema "products" do
    field :category, :string
    field :name, :string
    field :quantity, :integer
    field :type, :string
    field :units, :string
    field :price, :integer

    belongs_to(:user, User)
    belongs_to(:business, Business)

    has_one(:product_container_images, ProductImagesContainer)

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :type, :price, :category, :quantity, :units, :user_id, :business_id])
    |> validate_required([:name, :type, :price, :category, :quantity, :units, :user_id, :business_id])
    |> validate_min_price()
  end

  defp validate_min_price(changeset) do
    case get_field(changeset, :price) do
      nil ->
        changeset
      price ->
        if price >= 200 do
          changeset
        else 
          add_error(changeset, :price, "Price is too low")
        end
    end
  end
  
end
