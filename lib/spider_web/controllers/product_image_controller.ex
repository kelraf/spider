defmodule SpiderWeb.ProductImageController do
  use SpiderWeb, :controller

  alias Spider.ProductsImages
  alias Spider.ProductsImages.ProductImage

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    prducts_images = ProductsImages.list_prducts_images()
    render(conn, "index.json", prducts_images: prducts_images)
  end

  def create(conn, %{"product_image" => product_image_params, "product_images_container_id" => product_images_container_id, "product_id" => product_id}) do
    
    data = %{
      image: hd(product_image_params),
      product_images_container_id: product_images_container_id,
      product_id: product_id
    }

    with {:ok, %ProductImage{} = product_image} <- ProductsImages.create_product_image(data) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", product_image_path(conn, :show, product_image))
      |> render("show.json", product_image: product_image)
    end

  end

  def show(conn, %{"id" => id}) do
    product_image = ProductsImages.get_product_image!(id)
    render(conn, "show.json", product_image: product_image)
  end

  def update(conn, %{"id" => id, "product_image" => product_image_params}) do
    product_image = ProductsImages.get_product_image!(id)

    with {:ok, %ProductImage{} = product_image} <- ProductsImages.update_product_image(product_image, product_image_params) do
      render(conn, "show.json", product_image: product_image)
    end
  end

  def delete(conn, %{"id" => id}) do

    product_image = ProductsImages.get_product_image!(id)

    attachment = product_image

    path = Spider.ProductsImagesUploader.url({attachment.image, attachment}) |> String.split("?") |> List.first

    Task.start(fn -> 
      Spider.ProductsImagesUploader.delete({path, attachment})
    end)

    with {:ok, %ProductImage{}} <- ProductsImages.delete_product_image(product_image) do
      send_resp(conn, :no_content, "")
    end

  end
end
