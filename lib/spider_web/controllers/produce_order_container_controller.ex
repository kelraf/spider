defmodule SpiderWeb.ProduceOrderContainerController do
  use SpiderWeb, :controller

  alias Spider.ProduceOrderContainers
  alias Spider.ProduceOrderContainers.ProduceOrderContainer
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    produce_order_containers = ProduceOrderContainers.list_produce_order_containers()
    render(
      conn, 
      "index.json", 
      produce_order_containers: produce_order_containers
      |> Repo.preload([
        produce_orders: [
          d_produce: []
        ],
        user: [
          avatar: []
        ]
      ])
    )
  end

  def create(conn, %{"produce_order_container" => produce_order_container_params}) do
    with {:ok, %ProduceOrderContainer{} = produce_order_container} <- ProduceOrderContainers.create_produce_order_container(produce_order_container_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", produce_order_container_path(conn, :show, produce_order_container))
      |> render(
        "show.json", 
        produce_order_container: produce_order_container
        |> Repo.preload([
          produce_orders: [
            d_produce: []
          ],
          user: [
            avatar: []
          ]
        ])
      )
    end
  end

  def show(conn, %{"id" => id}) do
    produce_order_container = ProduceOrderContainers.get_produce_order_container!(id)
    render(
      conn, 
      "show.json", 
      produce_order_container: produce_order_container
      |> Repo.preload([
        produce_orders: [
          d_produce: []
        ],
        user: [
          avatar: []
        ]
      ])
    )
  end

  def update(conn, %{"id" => id, "produce_order_container" => produce_order_container_params}) do
    produce_order_container = ProduceOrderContainers.get_produce_order_container!(id)

    with {:ok, %ProduceOrderContainer{} = produce_order_container} <- ProduceOrderContainers.update_produce_order_container(produce_order_container, produce_order_container_params) do
      render(
        conn, 
        "show.json", 
        produce_order_container: produce_order_container
        |> Repo.preload([
          produce_orders: [
            d_produce: []
          ],
          user: [
            avatar: []
          ]
        ])
      )
    end
  end

  def delete(conn, %{"id" => id}) do
    produce_order_container = ProduceOrderContainers.get_produce_order_container!(id)
    with {:ok, %ProduceOrderContainer{}} <- ProduceOrderContainers.delete_produce_order_container(produce_order_container) do
      send_resp(conn, :no_content, "")
    end
  end
end