defmodule SpiderWeb.LivestockSaleController do
  use SpiderWeb, :controller

  alias Spider.LivestockSales
  alias Spider.LivestockSales.LivestockSale
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    livestock_sales = LivestockSales.list_livestock_sales()
    render(
      conn, 
      "index.json", 
      livestock_sales: livestock_sales
      |> Repo.preload([
        business: [
          user: [],
          business_assets: []
        ], 
        d_livestock: [
          d_livestock_images: []
        ]
      ])
    )
  end

  def create(conn, %{"livestock_sale" => livestock_sale_params}) do
    with {:ok, %LivestockSale{} = livestock_sale} <- LivestockSales.create_livestock_sale(livestock_sale_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", livestock_sale_path(conn, :show, livestock_sale))
      |> render(
        "show.json", 
        livestock_sale: livestock_sale
        |> Repo.preload([
          business: [
            user: [],
            business_assets: []
          ], 
          d_livestock: [
            d_livestock_images: []
          ]
        ])
      )
    end
  end

  def show(conn, %{"id" => id}) do
    livestock_sale = LivestockSales.get_livestock_sale!(id)
    render(
      conn, 
      "show.json", 
      livestock_sale: livestock_sale
      |> Repo.preload([
        business: [
          user: [],
          business_assets: []
        ], 
        d_livestock: [
          d_livestock_images: []
        ]
      ])
    )
  end

  def update(conn, %{"id" => id, "livestock_sale" => livestock_sale_params}) do
    livestock_sale = LivestockSales.get_livestock_sale!(id)

    with {:ok, %LivestockSale{} = livestock_sale} <- LivestockSales.update_livestock_sale(livestock_sale, Map.put_new(livestock_sale_params, "current_resource_id", id)) do
      render(
        conn, 
        "show.json", 
        livestock_sale: livestock_sale
        |> Repo.preload([
          business: [
            user: [],
            business_assets: []
          ], 
          d_livestock: [
            d_livestock_images: []
          ]
        ])  
      )
    end
  end

  def delete(conn, %{"id" => id}) do
    livestock_sale = LivestockSales.get_livestock_sale!(id)
    with {:ok, %LivestockSale{}} <- LivestockSales.delete_livestock_sale(livestock_sale) do
      send_resp(conn, :no_content, "")
    end
  end
end
