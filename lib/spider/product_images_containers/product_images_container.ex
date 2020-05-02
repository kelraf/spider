defmodule Spider.ProductImagesContainers.ProductImagesContainer do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Spider.Businesses.Business
  alias Spider.Products.Product
  alias Spider.Helpers.SpiderData
  alias Spider.ProductsImages.ProductImage
  alias Spider.Repo

  schema "product_container_images" do

    belongs_to(:business, Business)
    belongs_to(:product, Product)

    has_many(:products_images, ProductImage)

    timestamps()
  end

  @doc false
  def changeset(product_images_container, attrs, action \\ "create") do
    product_images_container
    |> cast(attrs, [:business_id, :product_id])
    |> validate_required([:business_id, :product_id])
    |> validate_product_images_container_one_for_business_and_product(action)
  end

  defp validate_product_images_container_one_for_business_and_product(changeset, action) do
    case get_field(changeset, :business_id) do
      nil ->
        changeset
      business_id ->
        case get_field(changeset, :product_id) do
          nil ->
            changeset
          product_id ->
            if action == "update" do
              changeset
            else

                query = from(
                    p in __MODULE__,
                    where: p.product_id == ^product_id and p.business_id == ^business_id,
                    select: p
                )

                case Repo.all(query) |> SpiderData.list_empty? do

                    false -> 
                        add_error(changeset, :product_id, "Oops!! Oparation Imposible. Please Just Update")
                    true ->
                        changeset
                end
                
            end
        end
    end
  end

end
