defmodule SpiderWeb.ProduceOrderController do
  use SpiderWeb, :controller

  alias Spider.ProduceOrders
  alias Spider.ProduceOrders.ProduceOrder
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    produce_orders = ProduceOrders.list_produce_orders()
    render(
      conn, 
      "index.json", 
      produce_orders: produce_orders
      |> preloader()
    )
  end

  def create(conn, %{"produce_order" => produce_order_params}) do
    with {:ok, %ProduceOrder{} = produce_order} <- ProduceOrders.create_produce_order(produce_order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", produce_order_path(conn, :show, produce_order))
      |> render(
        "show.json", 
        produce_order: produce_order
        |> preloader() 
      )
    end
  end

  def show(conn, %{"id" => id}) do
    produce_order = ProduceOrders.get_produce_order!(id)
    render(
      conn, 
      "show.json", 
      produce_order: produce_order
      |> preloader() 
    )
  end

  def update(conn, %{"id" => id, "produce_order" => produce_order_params}) do
    produce_order = ProduceOrders.get_produce_order!(id)

    with {:ok, %ProduceOrder{} = produce_order} <- ProduceOrders.update_produce_order(produce_order, produce_order_params) do
      render(
        conn, 
        "show.json", 
        produce_order: produce_order
        |> preloader() 
      )
    end
  end

  def delete(conn, %{"id" => id}) do

    produce_order = ProduceOrders.get_produce_order!(id)
    with {:ok, %ProduceOrder{}} <- ProduceOrders.delete_produce_order(produce_order) do
      send_resp(conn, :no_content, "")
    end

  end

  defp preloader(resource) do

    resource
    |> Repo.preload([
      d_produce: [],
      produce_order_stages: [
        produce_center_order: [],
        c_c_p_p_orders: []
      ]
    ]) 

  end

end
