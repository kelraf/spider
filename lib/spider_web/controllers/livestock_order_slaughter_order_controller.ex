defmodule SpiderWeb.LivestockOrderSlaughterOrderController do
  use SpiderWeb, :controller

  alias Spider.LivestockOrderSlaughterOrders
  alias Spider.LivestockOrderSlaughterOrders.LivestockOrderSlaughterOrder
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    livestock_order_slaughter_orders = LivestockOrderSlaughterOrders.list_livestock_order_slaughter_orders()
    render(
      conn, "index.json", 
      livestock_order_slaughter_orders: livestock_order_slaughter_orders 
      |> Repo.preload(
        [
          livestock_order_slaughter_order_outputs: [
            d_livestock_slaughter_output: []
          ],
          business: [
            business_assets: [],
            user: []
          ],
          livestock_order: [
            d_livestock: [
              d_livestock_images: []
            ]
          ]
        ]
      )
    )
  end

  def create(conn, %{"livestock_order_slaughter_order" => livestock_order_slaughter_order_params}) do
    with {:ok, %LivestockOrderSlaughterOrder{} = livestock_order_slaughter_order} <- LivestockOrderSlaughterOrders.create_livestock_order_slaughter_order(livestock_order_slaughter_order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", livestock_order_slaughter_order_path(conn, :show, livestock_order_slaughter_order))
      |> render(
        "show.json", 
        livestock_order_slaughter_order: livestock_order_slaughter_order 
        |> Repo.preload(
          [
            livestock_order_slaughter_order_outputs: [
              d_livestock_slaughter_output: []
            ],
            business: [
              business_assets: [],
              user: []
            ],
            livestock_order: [
              d_livestock: [
                d_livestock_images: []
              ]
            ]
          ]
        ) 
      )
    end
  end

  def show(conn, %{"id" => id}) do
    livestock_order_slaughter_order = LivestockOrderSlaughterOrders.get_livestock_order_slaughter_order!(id)
    render(
      conn, 
      "show.json", livestock_order_slaughter_order: livestock_order_slaughter_order 
      |> Repo.preload(
        [
          livestock_order_slaughter_order_outputs: [
            d_livestock_slaughter_output: []
          ],
          business: [
            business_assets: [],
            user: []
          ],
          livestock_order: [
            d_livestock: [
              d_livestock_images: []
            ]
          ]
        ]
      ) 
    )
  end

  def update(conn, %{"id" => id, "livestock_order_slaughter_order" => livestock_order_slaughter_order_params}) do
    livestock_order_slaughter_order = LivestockOrderSlaughterOrders.get_livestock_order_slaughter_order!(id)

    with {:ok, %LivestockOrderSlaughterOrder{} = livestock_order_slaughter_order} <- LivestockOrderSlaughterOrders.update_livestock_order_slaughter_order(livestock_order_slaughter_order, livestock_order_slaughter_order_params) do
      render(
        conn, 
        "show.json", 
        livestock_order_slaughter_order: livestock_order_slaughter_order  
        |> Repo.preload(
          [
            livestock_order_slaughter_order_outputs: [
              d_livestock_slaughter_output: []
            ],
            business: [
              business_assets: [],
              user: []
            ],
            livestock_order: [
              d_livestock: [
                d_livestock_images: []
              ]
            ]
          ]
        )
      )
    end
  end

  def delete(conn, %{"id" => id}) do
    livestock_order_slaughter_order = LivestockOrderSlaughterOrders.get_livestock_order_slaughter_order!(id)
    with {:ok, %LivestockOrderSlaughterOrder{}} <- LivestockOrderSlaughterOrders.delete_livestock_order_slaughter_order(livestock_order_slaughter_order) do
      send_resp(conn, :no_content, "")
    end
  end
end
