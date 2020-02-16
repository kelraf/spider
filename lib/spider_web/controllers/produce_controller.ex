defmodule SpiderWeb.ProduceController do
  use SpiderWeb, :controller

  alias Spider.Produces
  alias Spider.Produces.Produce

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    produces = Produces.list_produces()
    render(conn, "index.json", produces: produces)
  end

  def create(conn, %{"produce" => produce_params}) do
    with {:ok, %Produce{} = produce} <- Produces.create_produce(produce_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", produce_path(conn, :show, produce))
      |> render("show.json", produce: produce)
    end
  end

  def show(conn, %{"id" => id}) do
    produce = Produces.get_produce!(id)
    render(conn, "show.json", produce: produce)
  end

  def update(conn, %{"id" => id, "produce" => produce_params}) do
    produce = Produces.get_produce!(id)

    with {:ok, %Produce{} = produce} <- Produces.update_produce(produce, produce_params) do
      render(conn, "show.json", produce: produce)
    end
  end

  def delete(conn, %{"id" => id}) do
    produce = Produces.get_produce!(id)
    with {:ok, %Produce{}} <- Produces.delete_produce(produce) do
      send_resp(conn, :no_content, "")
    end
  end
end
