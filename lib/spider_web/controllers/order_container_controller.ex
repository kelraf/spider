defmodule SpiderWeb.OrderContainerController do
  use SpiderWeb, :controller

  alias Spider.OrderContainers
  alias Spider.OrderContainers.OrderContainer

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    ordercontainers = OrderContainers.list_ordercontainers()
    render(conn, "index.json", ordercontainers: ordercontainers)
  end

  def get_order_container_using_business_id(conn, %{"business_id" => business_id}) do
    
    case OrderContainers.get_order_container_using_business_id(business_id) do
      {:empty, _nonses} ->
        conn
        |> json(%{
          message: "No Order Container Related To Your Business"
        })

      {:ok, ordercontainers} ->
        conn
        |> render("index.json", ordercontainers: ordercontainers)
        
    end

  end

  def create(conn, %{"order_container" => order_container_params}) do
    with {:ok, %OrderContainer{} = order_container} <- OrderContainers.create_order_container(order_container_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", order_container_path(conn, :show, order_container))
      |> render("show.json", order_container: order_container)
    end
  end

  def show(conn, %{"id" => id}) do
    order_container = OrderContainers.get_order_container!(id)
    render(conn, "show.json", order_container: order_container)
  end

  def update(conn, %{"id" => id, "order_container" => order_container_params}) do
    order_container = OrderContainers.get_order_container!(id)

    with {:ok, %OrderContainer{} = order_container} <- OrderContainers.update_order_container(order_container, order_container_params) do
      render(conn, "show.json", order_container: order_container)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_container = OrderContainers.get_order_container!(id)
    with {:ok, %OrderContainer{}} <- OrderContainers.delete_order_container(order_container) do
      send_resp(conn, :no_content, "")
    end
  end
end
