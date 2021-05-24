defmodule SpiderWeb.ProduceCenterOrderController do
  use SpiderWeb, :controller

  alias Spider.ProduceCenterOrders
  alias Spider.ProduceCenterOrders.ProduceCenterOrder

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    produce_center_orders = ProduceCenterOrders.list_produce_center_orders()
    render(conn, "index.json", produce_center_orders: produce_center_orders)
  end

  def create(conn, %{"produce_center_order" => produce_center_order_params}) do
    with {:ok, %ProduceCenterOrder{} = produce_center_order} <- ProduceCenterOrders.create_produce_center_order(produce_center_order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", produce_center_order_path(conn, :show, produce_center_order))
      |> render("show.json", produce_center_order: produce_center_order)
    end
  end

  def show(conn, %{"id" => id}) do
    produce_center_order = ProduceCenterOrders.get_produce_center_order!(id)
    render(conn, "show.json", produce_center_order: produce_center_order)
  end

  def update(conn, %{"id" => id, "produce_center_order" => produce_center_order_params}) do
    produce_center_order = ProduceCenterOrders.get_produce_center_order!(id)

    with {:ok, %ProduceCenterOrder{} = produce_center_order} <- ProduceCenterOrders.update_produce_center_order(produce_center_order, produce_center_order_params) do
      render(conn, "show.json", produce_center_order: produce_center_order)
    end
  end

  def delete(conn, %{"id" => id}) do
    produce_center_order = ProduceCenterOrders.get_produce_center_order!(id)
    with {:ok, %ProduceCenterOrder{}} <- ProduceCenterOrders.delete_produce_center_order(produce_center_order) do
      send_resp(conn, :no_content, "")
    end
  end
end
