defmodule SpiderWeb.LivestockOrderContainerController do
  use SpiderWeb, :controller

  alias Spider.LivestockOrderContainers
  alias Spider.LivestockOrderContainers.LivestockOrderContainer
  alias Spider.Repo

  action_fallback(SpiderWeb.FallbackController)

  def index(conn, _params) do
    livestock_order_containers = LivestockOrderContainers.list_livestock_order_containers()

    render(
      conn,
      "index.json",
      livestock_order_containers:
        livestock_order_containers
        |> preloader()
    )
  end

  # , :livestock_order_stages
  def create(conn, %{"livestock_order_container" => livestock_order_container_params}) do
    with {:ok, %LivestockOrderContainer{} = livestock_order_container} <-
           LivestockOrderContainers.create_livestock_order_container(
             livestock_order_container_params
           ) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        livestock_order_container_path(conn, :show, livestock_order_container)
      )
      |> render(
        "show.json",
        livestock_order_container:
          livestock_order_container
          |> preloader()
      )
    end
  end

  def show(conn, %{"id" => id}) do
    livestock_order_container = LivestockOrderContainers.get_livestock_order_container!(id)

    render(
      conn,
      "show.json",
      livestock_order_container:
        livestock_order_container
        |> preloader()
    )
  end

  def update(conn, %{"id" => id, "livestock_order_container" => livestock_order_container_params}) do

    livestock_order_container = LivestockOrderContainers.get_livestock_order_container!(id)

    with {:ok, %LivestockOrderContainer{} = livestock_order_container} <- LivestockOrderContainers.update_livestock_order_container(livestock_order_container, livestock_order_container_params) do
      render(
        conn,
        "show.json",
        livestock_order_container: livestock_order_container 
        |> preloader()
      )
    end
  end

  def delete(conn, %{"id" => id}) do
    livestock_order_container = LivestockOrderContainers.get_livestock_order_container!(id)

    with {:ok, %LivestockOrderContainer{}} <-
           LivestockOrderContainers.delete_livestock_order_container(livestock_order_container) do
      send_resp(conn, :no_content, "")
    end
  end

  defp preloader(resource) do
    resource
    |> Repo.preload(
        user: :avatar,
        livestock_orders: [
          d_livestock: [
            :d_livestock_images
          ],
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
        ]
    )

  end
end
