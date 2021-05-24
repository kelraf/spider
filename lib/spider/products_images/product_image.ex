defmodule Spider.ProductsImages.ProductImage do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
    
  alias Spider.ProductImagesContainers.ProductImagesContainer
  alias Spider.Toolkit.Constants.Products
  alias Spider.Products.Product
  alias Spider.Helpers.SpiderData
  alias Spider.Repo

  schema "products_images" do

    field :image, Spider.ProductsImagesUploader.Type

    field :uuid, :string
    field(:image_limit, :string, virtual: true)
    belongs_to(:product_images_container, ProductImagesContainer)
    belongs_to(:product, Product)

    timestamps()
  end

  @doc false
  def changeset(product_image, attrs) do
    product_image
    |> cast(attrs, [:uuid, :product_images_container_id, :product_id])
    |> put_change(:uuid, Ecto.UUID.generate)
    |> validate_required([:uuid, :product_images_container_id, :product_id])
    |> validate_galary_image_limit()
    |> cast_attachments(attrs, [:image])
    |> create_image_name()
  end

  defp validate_galary_image_limit(changeset) do
    case get_field(changeset, :product_images_container_id) do
      nil ->
        changeset
      product_container_image_id ->
        query = from(
            i in __MODULE__,
            where: i.product_images_container_id == ^product_container_image_id,
            select: i
        )

        data = Repo.all(query)

        case data |> SpiderData.list_empty? do

            false -> 
              
              cond do
                length(data) >= Products.products_galary_image_limit ->
                  add_error(changeset, :image_limit, "Image Limit Riched.")
                length(data) < Products.products_galary_image_limit ->
                  changeset
              end

            true ->
              changeset
        end

    end
  end

  defp create_image_name(changeset) do
    
    case get_field(changeset, :product_images_container_id) do
      nil ->
        changeset
      product_images_container_id ->
        case get_field(changeset, :image) do
          nil -> 
            changeset
          image -> 
            case get_field(changeset, :uuid) do
              nil -> 
                changeset
              uuid ->

                case get_field(changeset, :product_id) do
                  nil -> 
                    changeset
                  product_id ->
                    new_image = Map.put(image, :file_name, "spider_#{uuid}_#{product_images_container_id}_#{product_id}#{Path.extname(image.file_name)}")
                    put_change(changeset, :image, new_image)
                end
                
            end
        end
    end
  end
  
end
