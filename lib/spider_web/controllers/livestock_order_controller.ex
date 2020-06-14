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
        |> Repo.preload(
          d_livestock: [:d_livestock_images],
          livestock_order_stages: [
            center_order: [:livestock_sales], 
            c_c_p_l_orders: [], 
            livestock_order_processing_stages: [
              livestock_order_slaughter_order: [
                livestock_order_slaughter_order_outputs: [],
                business: [
                  business_assets: [],
                  user: []
                ]
              ]
            ], 
            export_zone_livestock_order: [
              export_zone_bundler: [
                business: [
                  business_assets: [], 
                  user: []
                ]
              ]
            ]
          ]
        )
    )
  end

  def create(conn, %{"livestock_order" => livestock_order_params}) do
    with {:ok, %LivestockOrder{} = livestock_order} <-
           LivestockOrders.create_livestock_order(livestock_order_params) do
      # center_order_data = %{
      #   required_animals: livestock_order.quantity,
      #   livestock_order_id: livestock_order.id,
      #   d_livestock_id: livestock_order.d_livestock_id
      # }

      # LivestockOrderContainer.validate_required_to_add_or_delete livestock_order, "create"
      # CenterOrders.create_center_order(center_order_data)

      conn
      |> put_status(:created)
      |> put_resp_header("location", livestock_order_path(conn, :show, livestock_order))
      |> render(
        "show.json",
        livestock_order:
          livestock_order
          |> Repo.preload(
            d_livestock: [:d_livestock_images],
            livestock_order_stages: [
              center_order: [:livestock_sales], 
              c_c_p_l_orders: [], 
              livestock_order_processing_stages: [
                livestock_order_slaughter_order: [
                  livestock_order_slaughter_order_outputs: [],
                  business: [
                    business_assets: [],
                    user: []
                  ]
                ]
              ], 
              export_zone_livestock_order: [
                export_zone_bundler: [
                  business: [
                    business_assets: [], 
                    user: []
                  ]
                ]
              ]
            ]
          )
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
        |> Repo.preload(
          d_livestock: [:d_livestock_images],
          livestock_order_stages: [
            center_order: [:livestock_sales], 
          c_c_p_l_orders: [], 
          livestock_order_processing_stages: [
            livestock_order_slaughter_order: [
              livestock_order_slaughter_order_outputs: [],
              business: [
                business_assets: [],
                user: []
              ]
            ]
          ], 
          export_zone_livestock_order: [
            export_zone_bundler: [
              business: [
                business_assets: [], 
                user: []
              ]
            ]
          ]
          ]
        )
    )
  end

  def update(conn, %{"id" => id, "livestock_order" => livestock_order_params}) do
    livestock_order = LivestockOrders.get_livestock_order!(id)

    # old_total_cost = livestock_order.total_cost

    with {:ok, %LivestockOrder{} = livestock_order} <-
           LivestockOrders.update_livestock_order(livestock_order, livestock_order_params) do
      # new_total_cost = livestock_order.total_cost

      # diff = new_total_cost - old_total_cost

      # LivestockOrderContainer.validate_required_to_add_or_delete livestock_order, "update", diff

      # center_order_data = %{
      #   required_animals: livestock_order.quantity,
      #   livestock_order_id: livestock_order.id,
      #   d_livestock_id: livestock_order.d_livestock_id
      # }

      # livestock_order_with_preloaded_data = livestock_order
      # |> Repo.preload(:center_order)

      # center_order_data_old = livestock_order_with_preloaded_data.center_order

      # CenterOrders.update_center_order(center_order_data_old, center_order_data)

      render(
        conn,
        "show.json",
        livestock_order:
          livestock_order
          |> Repo.preload(
            d_livestock: [:d_livestock_images],
            livestock_order_stages: [
              center_order: [:livestock_sales], 
              c_c_p_l_orders: [], 
              livestock_order_processing_stages: [
                livestock_order_slaughter_order: [
                  livestock_order_slaughter_order_outputs: [],
                  business: [
                    business_assets: [],
                    user: []
                  ]
                ]
              ], 
              export_zone_livestock_order: [
                export_zone_bundler: [
                  business: [
                    business_assets: [], 
                    user: []
                  ]
                ]
              ]
            ]
          )
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
end
