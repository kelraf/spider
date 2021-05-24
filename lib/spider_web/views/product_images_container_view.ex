defmodule SpiderWeb.ProductImagesContainerView do
  use SpiderWeb, :view
  alias SpiderWeb.ProductImagesContainerView
  alias SpiderWeb.ProductImageView

  def render("index.json", %{product_container_images: product_container_images}) do
    %{data: render_many(product_container_images, ProductImagesContainerView, "product_images_container.json")}
  end

  def render("show.json", %{product_images_container: product_images_container}) do
    %{data: render_one(product_images_container, ProductImagesContainerView, "product_images_container.json")}
  end

  def render("product_images_container.json", %{product_images_container: product_images_container}) do
    %{
      id: product_images_container.id,
      business_id: product_images_container.business_id,
      product_id: product_images_container.product_id,
      products_images: render_many(product_images_container.products_images, ProductImageView, "product_image.json", as: :product_image)
    }
  end
end
