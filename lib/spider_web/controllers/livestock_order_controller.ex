defmodule SpiderWeb.LivestockOrderController do
  use SpiderWeb, :controller

  alias Spider.LivestockOrders
  alias Spider.LivestockOrders.LivestockOrder
  alias Spider.Context.LivestockOrderContainer
  alias Spider.CenterOrders
  alias Spider.Repo

  action_fallback(SpiderWeb.FallbackController)

  def index(conn, _params) do
    livestock_orders = LivestockOrders.list_livestock_orders()

    render(
      conn,
      "index.json",
      livestock_orders:
        livestock_orders
        |> preloader()
    )
  end

  def create(conn, %{"livestock_order" => livestock_order_params}) do

    with {:ok, %LivestockOrder{} = livestock_order} <- LivestockOrders.create_livestock_order(livestock_order_params) do

      conn
      |> put_status(:created)
      |> put_resp_header("location", livestock_order_path(conn, :show, livestock_order))
      |> render(
        "show.json",
        livestock_order:
          livestock_order
          |> preloader()
      )
    end
  end

  def show(conn, %{"id" => id}) do
    livestock_order = LivestockOrders.get_livestock_order!(id)

    render(
      conn,
      "show.json",
      livestock_order:
        livestock_order
        |> preloader()
    )
  end

  def update(conn, %{"id" => id, "livestock_order" => livestock_order_params}) do
    livestock_order = LivestockOrders.get_livestock_order!(id)

    with {:ok, %LivestockOrder{} = livestock_order} <- LivestockOrders.update_livestock_order(livestock_order, livestock_order_params) do

      render(
        conn,
        "show.json",
        livestock_order:
          livestock_order
          |> preloader()
      )
    end
  end

  def delete(conn, %{"id" => id}) do
    livestock_order = LivestockOrders.get_livestock_order!(id)

    with {:ok, %LivestockOrder{}} <- LivestockOrders.delete_livestock_order(livestock_order) do
      LivestockOrderContainer.validate_required_to_add_or_delete(livestock_order, "delete")

      send_resp(conn, :no_content, "")
    end
  end

  defp preloader(resource) do

    resource
    |> Repo.preload(
      d_livestock: [:d_livestock_images],
      livestock_order_stages: [
        center_order: [
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
        ], 
        c_c_p_l_orders: [], 
        livestock_order_processing_stages: [
          livestock_order_slaughter_orders: [
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
        ], 
        export_zone_livestock_orders: [
          export_zone_bundler: [
            business: [
              business_assets: [], 
              user: []
            ],
            export_zone_livestock_orders: [
              livestock_order: [
                d_livestock: [
                  d_livestock_images: []
                ]
              ]
            ]
          ]
        ],
        feed_lot_livestock_orders: [
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
        ]
      ]
    )

  end

end
