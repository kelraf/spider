defmodule SpiderWeb.ProductImagesContainerController do
  use SpiderWeb, :controller

  alias Spider.ProductImagesContainers
  alias Spider.ProductImagesContainers.ProductImagesContainer
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    product_container_images = ProductImagesContainers.list_product_container_images() |> Repo.preload(:products_images)
    render(conn, "index.json", product_container_images: product_container_images)
  end

  def create(conn, %{"product_images_container" => product_images_container_params}) do
    with {:ok, %ProductImagesContainer{} = product_images_container} <- ProductImagesContainers.create_product_images_container(product_images_container_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", product_images_container_path(conn, :show, product_images_container))
      |> render("show.json", product_images_container: product_images_container |> Repo.preload(:products_images))
    end
  end

  def show(conn, %{"id" => id}) do
    product_images_container = ProductImagesContainers.get_product_images_container!(id) |> Repo.preload(:products_images)
    render(conn, "show.json", product_images_container: product_images_container)
  end

  def update(conn, %{"id" => id, "product_images_container" => product_images_container_params}) do
    product_images_container = ProductImagesContainers.get_product_images_container!(id)

    with {:ok, %ProductImagesContainer{} = product_images_container} <- ProductImagesContainers.update_product_images_container(product_images_container, product_images_container_params) do
      render(conn, "show.json", product_images_container: product_images_container |> Repo.preload(:products_images))
    end
  end

  def delete(conn, %{"id" => id}) do
    product_images_container = ProductImagesContainers.get_product_images_container!(id)
    with {:ok, %ProductImagesContainer{}} <- ProductImagesContainers.delete_product_images_container(product_images_container) do
      send_resp(conn, :no_content, "")
    end
  end
end
