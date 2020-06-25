defmodule SpiderWeb.CenterOrderController do
  use SpiderWeb, :controller

  alias Spider.CenterOrders
  alias Spider.CenterOrders.CenterOrder
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    center_orders = CenterOrders.list_center_orders()
    render(
      conn, 
      "index.json", 
      center_orders: center_orders
      |> Repo.preload([
        livestock_sales: [
          business: [
            user: [],
            business_assets: []
          ], 
          d_livestock: [
            d_livestock_images: []
          ]
        ], 
        d_livestock: [
          d_livestock_images: []
        ]
      ])
    )
  end

  def create(conn, %{"center_order" => center_order_params}) do
    with {:ok, %CenterOrder{} = center_order} <- CenterOrders.create_center_order(center_order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", center_order_path(conn, :show, center_order))
      |> render(
        "show.json", 
        center_order: center_order 
        |> Repo.preload([
          livestock_sales: [
            business: [
              user: [],
              business_assets: []
            ], 
            d_livestock: [
              d_livestock_images: []
            ]
          ], 
          d_livestock: [
            d_livestock_images: []
          ]
        ]))
    end
  end

  def show(conn, %{"id" => id}) do
    center_order = CenterOrders.get_center_order!(id)
    render(
      conn, 
      "show.json", 
      center_order: center_order 
      |> Repo.preload([
        livestock_sales: [
          business: [
            user: [],
            business_assets: []
          ], 
          d_livestock: [
            d_livestock_images: []
          ]
        ], 
        d_livestock: [
          d_livestock_images: []
        ]
      ])
    )
  end

  def update(conn, %{"id" => id, "center_order" => center_order_params}) do
    center_order = CenterOrders.get_center_order!(id)

    with {:ok, %CenterOrder{} = center_order} <- CenterOrders.update_center_order(center_order, center_order_params) do
      render(
        conn, 
        "show.json", 
        center_order: center_order 
        |> Repo.preload([
          livestock_sales: [
            business: [
              user: [],
              business_assets: []
            ], 
            d_livestock: [
              d_livestock_images: []
            ]
          ], 
          d_livestock: [
            d_livestock_images: []
          ]
        ])
      )
    end
  end

  def delete(conn, %{"id" => id}) do
    center_order = CenterOrders.get_center_order!(id)
    with {:ok, %CenterOrder{}} <- CenterOrders.delete_center_order(center_order) do
      send_resp(conn, :no_content, "")
    end
  end
end
