defmodule SpiderWeb.LivestockOrderContainerController do
  use SpiderWeb, :controller

  alias Spider.LivestockOrderContainers
  alias Spider.LivestockOrderContainers.LivestockOrderContainer
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    livestock_order_containers = LivestockOrderContainers.list_livestock_order_containers() |> Repo.preload([user: :avatar, livestock_orders: [dlivestock: [:d_livestock_images], center_order: [:livestock_sales]]])
    render(conn, "index.json", livestock_order_containers: livestock_order_containers)
  end

  def create(conn, %{"livestock_order_container" => livestock_order_container_params}) do

    with {:ok, %LivestockOrderContainer{} = livestock_order_container} <- LivestockOrderContainers.create_livestock_order_container(livestock_order_container_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", livestock_order_container_path(conn, :show, livestock_order_container))
      |> render("show.json", livestock_order_container: livestock_order_container |> Repo.preload([user: :avatar, livestock_orders: [dlivestock: [:d_livestock_images], center_order: [:livestock_sales]]]))
    end

  end

  def show(conn, %{"id" => id}) do
    livestock_order_container = LivestockOrderContainers.get_livestock_order_container!(id) |> Repo.preload([user: :avatar, livestock_orders: [dlivestock: [:d_livestock_images], center_order: [:livestock_sales]]])
    render(conn, "show.json", livestock_order_container: livestock_order_container)
  end

  def update(conn, %{"id" => id, "livestock_order_container" => livestock_order_container_params}) do
    livestock_order_container = LivestockOrderContainers.get_livestock_order_container!(id) |> Repo.preload([user: :avatar, livestock_orders: [dlivestock: [:d_livestock_images], center_order: [:livestock_sales]]])

    with {:ok, %LivestockOrderContainer{} = livestock_order_container} <- LivestockOrderContainers.update_livestock_order_container(livestock_order_container, livestock_order_container_params) do
      render(conn, "show.json", livestock_order_container: livestock_order_container |> Repo.preload([user: :avatar, livestock_orders: [dlivestock: [:d_livestock_images], center_order: [:livestock_sales]]]))
    end
  end

  def delete(conn, %{"id" => id}) do
    livestock_order_container = LivestockOrderContainers.get_livestock_order_container!(id)
    with {:ok, %LivestockOrderContainer{}} <- LivestockOrderContainers.delete_livestock_order_container(livestock_order_container) do
      send_resp(conn, :no_content, "")
    end
  end
  
end
