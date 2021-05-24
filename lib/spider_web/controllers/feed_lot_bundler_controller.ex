defmodule SpiderWeb.FeedLotBundlerController do
  use SpiderWeb, :controller

  alias Spider.FeedLotBundlers
  alias Spider.FeedLotBundlers.FeedLotBundler
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    feed_lot_bundlers = FeedLotBundlers.list_feed_lot_bundlers()
    render(
      conn, 
      "index.json", 
      feed_lot_bundlers: feed_lot_bundlers
      |> Repo.preload([
        business: [
          :business_assets, 
          :user
        ],
        feed_lot_livestock_orders: [
          livestock_order: [
            d_livestock: [
              d_livestock_images: []
            ]
          ]
        ]
      ])
    )
  end

  def get_by_business_id(conn, %{"business_id" => business_id}) do

    render(
      conn, 
      "show.json", 
      feed_lot_bundler: 
        Repo.get_by!(FeedLotBundler, business_id: business_id)
        |> Repo.preload([
          business: [
            :business_assets, 
            :user
          ],
          feed_lot_livestock_orders: [
            livestock_order: [
              d_livestock: [
                d_livestock_images: []
              ]
            ]
          ]
        ])
      )
      
  end

  def create(conn, %{"feed_lot_bundler" => feed_lot_bundler_params}) do
    with {:ok, %FeedLotBundler{} = feed_lot_bundler} <- FeedLotBundlers.create_feed_lot_bundler(feed_lot_bundler_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", feed_lot_bundler_path(conn, :show, feed_lot_bundler))
      |> render(
        "show.json", 
        feed_lot_bundler: feed_lot_bundler
        |> Repo.preload([
          business: [
            :business_assets, 
            :user
          ],
          feed_lot_livestock_orders: [
            livestock_order: [
              d_livestock: [
                d_livestock_images: []
              ]
            ]
          ]
        ])
      )
    end
  end

  def show(conn, %{"id" => id}) do
    feed_lot_bundler = FeedLotBundlers.get_feed_lot_bundler!(id)
    render(
      conn, 
      "show.json", 
      feed_lot_bundler: feed_lot_bundler
      |> Repo.preload([
        business: [
          :business_assets, 
          :user
        ],
        feed_lot_livestock_orders: [
          livestock_order: [
            d_livestock: [
              d_livestock_images: []
            ]
          ]
        ]
      ])
    )
  end

  def update(conn, %{"id" => id, "feed_lot_bundler" => feed_lot_bundler_params}) do
    feed_lot_bundler = FeedLotBundlers.get_feed_lot_bundler!(id)

    with {:ok, %FeedLotBundler{} = feed_lot_bundler} <- FeedLotBundlers.update_feed_lot_bundler(feed_lot_bundler, feed_lot_bundler_params) do
      render(
        conn, 
        "show.json", 
        feed_lot_bundler: feed_lot_bundler
        |> Repo.preload([
          business: [
            :business_assets, 
            :user
          ],
          feed_lot_livestock_orders: [
            livestock_order: [
              d_livestock: [
                d_livestock_images: []
              ]
            ]
          ]
        ])
      )
    end
  end

  def delete(conn, %{"id" => id}) do
    feed_lot_bundler = FeedLotBundlers.get_feed_lot_bundler!(id)
    with {:ok, %FeedLotBundler{}} <- FeedLotBundlers.delete_feed_lot_bundler(feed_lot_bundler) do
      send_resp(conn, :no_content, "")
    end
  end
end
