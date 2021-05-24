defmodule SpiderWeb.FeedLotLivestockOrderController do
  use SpiderWeb, :controller

  alias Spider.FeedLotLivestockOrders
  alias Spider.FeedLotLivestockOrders.FeedLotLivestockOrder
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    feed_lot_livestock_orders = FeedLotLivestockOrders.list_feed_lot_livestock_orders()
    render(
      conn, 
      "index.json", 
      feed_lot_livestock_orders: feed_lot_livestock_orders
      |> Repo.preload([
          feed_lot_bundler: [
            business: [
              business_assets: [], 
              user: []
            ],
            feed_lot_livestock_orders: [
              livestock_order: [
                d_livestock: [
                  d_livestock_images: []
                ]
              ]
            ]
          ]
      ])
    )
  end

  def create(conn, %{"feed_lot_livestock_order" => feed_lot_livestock_order_params}) do
    with {:ok, %FeedLotLivestockOrder{} = feed_lot_livestock_order} <- FeedLotLivestockOrders.create_feed_lot_livestock_order(feed_lot_livestock_order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", feed_lot_livestock_order_path(conn, :show, feed_lot_livestock_order))
      |> render(
        "show.json", 
        feed_lot_livestock_order: feed_lot_livestock_order
        |> Repo.preload([
            feed_lot_bundler: [
              business: [
                business_assets: [], 
                user: []
              ],
              feed_lot_livestock_orders: [
                livestock_order: [
                  d_livestock: [
                    d_livestock_images: []
                  ]
                ]
              ]
            ]
        ])  
      )
    end
  end

  def show(conn, %{"id" => id}) do
    feed_lot_livestock_order = FeedLotLivestockOrders.get_feed_lot_livestock_order!(id)
    render(
      conn, 
      "show.json", 
      feed_lot_livestock_order: feed_lot_livestock_order
      |> Repo.preload([
          feed_lot_bundler: [
            business: [
              business_assets: [], 
              user: []
            ],
            feed_lot_livestock_orders: [
              livestock_order: [
                d_livestock: [
                  d_livestock_images: []
                ]
              ]
            ]
          ]
      ])  
    )
  end

  def update(conn, %{"id" => id, "feed_lot_livestock_order" => feed_lot_livestock_order_params}) do
    feed_lot_livestock_order = FeedLotLivestockOrders.get_feed_lot_livestock_order!(id) |> IO.inspect

    with {:ok, %FeedLotLivestockOrder{} = feed_lot_livestock_order} <- FeedLotLivestockOrders.update_feed_lot_livestock_order(feed_lot_livestock_order, feed_lot_livestock_order_params) do
      render(
        conn, 
        "show.json", 
        feed_lot_livestock_order: feed_lot_livestock_order
        |> Repo.preload([
            feed_lot_bundler: [ 
              business: [
                business_assets: [], 
                user: []
              ],
              feed_lot_livestock_orders: [
                livestock_order: [
                  d_livestock: [
                    d_livestock_images: []
                  ]
                ]
              ]
            ]
        ])  
      )
    end
  end

  def delete(conn, %{"id" => id}) do
    feed_lot_livestock_order = FeedLotLivestockOrders.get_feed_lot_livestock_order!(id)
    with {:ok, %FeedLotLivestockOrder{}} <- FeedLotLivestockOrders.delete_feed_lot_livestock_order(feed_lot_livestock_order) do
      send_resp(conn, :no_content, "")
    end
  end
end
