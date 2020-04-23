defmodule SpiderWeb.ProductController do
  use SpiderWeb, :controller

  alias Spider.Products
  alias Spider.Products.Product

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, "index.json", products: products)
  end

  def get_products_using_business_id(conn, %{"business_id" => business_id}) do
    
    case Products.get_products_using_business_id(business_id) do
      {:empty, _rubish} ->
        conn
        |> json(%{
          data: [],
          message: "No Products Related To This Business"
        })

      {:ok, products} ->
        conn
        |> render("index.json", products: products)
        
    end

  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Products.create_product(product_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", product_path(conn, :show, product))
      |> render("show.json", product: product)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Products.get_product!(id)

    with {:ok, %Product{} = product} <- Products.update_product(product, product_params) do
      render(conn, "show.json", product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    with {:ok, %Product{}} <- Products.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
