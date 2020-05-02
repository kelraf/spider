defmodule SpiderWeb.ProductView do
  use SpiderWeb, :view
  alias SpiderWeb.ProductView
  alias SpiderWeb.ProductImagesContainerView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      name: product.name,
      type: product.type,
      category: product.category,
      quantity: product.quantity,
      units: product.units,
      user_id: product.user_id,
      business_id: product.business_id,
      product_container_images: render_one(product.product_container_images, ProductImagesContainerView, "product_images_container.json", as: :product_images_container)
    }
  end
end
