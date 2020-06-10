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
        |> Repo.preload(
          user: :avatar,
          livestock_orders: [
            d_livestock: [:d_livestock_images],
            livestock_order_stages: [center_order: [:livestock_sales], c_c_p_l_orders: [], export_zone_livestock_order: [export_zone_bundler: [business: [business_assets: [], user: []]]]]
          ]
        )
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
          |> Repo.preload(
            user: :avatar,
            livestock_orders: [
              d_livestock: [:d_livestock_images],
              livestock_order_stages: [center_order: [:livestock_sales], c_c_p_l_orders: [], export_zone_livestock_order: [export_zone_bundler: [business: [business_assets: [], user: []]]]]
            ]
          )
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
        |> Repo.preload(
          user: :avatar,
          livestock_orders: [
            d_livestock: [:d_livestock_images],
            livestock_order_stages: [center_order: [:livestock_sales], c_c_p_l_orders: [], export_zone_livestock_order: [export_zone_bundler: [business: [business_assets: [], user: []]]]]
          ]
        )
    )
  end

  def update(conn, %{"id" => id, "livestock_order_container" => livestock_order_container_params}) do
    livestock_order_container =
      LivestockOrderContainers.get_livestock_order_container!(id)
      |> Repo.preload(
        user: :avatar,
        livestock_orders: [
          d_livestock: [:d_livestock_images],
          livestock_order_stages: [center_order: [:livestock_sales], c_c_p_l_orders: [], export_zone_livestock_order: [export_zone_bundler: [business: [business_assets: [], user: []]]]]
        ]
      )

    with {:ok, %LivestockOrderContainer{} = livestock_order_container} <-
           LivestockOrderContainers.update_livestock_order_container(
             livestock_order_container,
             livestock_order_container_params
           ) do
      render(
        conn,
        "show.json",
        livestock_order_container:
          livestock_order_container
          |> Repo.preload(
            user: :avatar,
            livestock_orders: [
              d_livestock: [:d_livestock_images],
              livestock_order_stages: [center_order: [:livestock_sales], c_c_p_l_orders: [], export_zone_livestock_order: [export_zone_bundler: [business: [business_assets: [], user: []]]]]
            ]
          )
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
end
