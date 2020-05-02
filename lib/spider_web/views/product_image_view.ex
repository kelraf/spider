defmodule SpiderWeb.ProductImageView do
  use SpiderWeb, :view
  alias SpiderWeb.ProductImageView

  def render("index.json", %{prducts_images: prducts_images}) do
    %{data: render_many(prducts_images, ProductImageView, "product_image.json")}
  end

  def render("show.json", %{product_image: product_image}) do
    %{data: render_one(product_image, ProductImageView, "product_image.json")}
  end

  def render("product_image.json", %{product_image: product_image}) do
    %{
      id: product_image.id,
      uuid: product_image.uuid,
      product_images_container_id: product_image.product_images_container_id,
      product_id: product_image.product_id,
      image: product_image.image
    }
  end
end
