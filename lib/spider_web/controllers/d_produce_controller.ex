defmodule SpiderWeb.DProduceController do
  use SpiderWeb, :controller

  alias Spider.DProduces
  alias Spider.DProduces.DProduce

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    dproduces = DProduces.list_dproduces()
    render(conn, "index.json", dproduces: dproduces)
  end

  def create(conn, %{"d_produce" => d_produce_params}) do
    with {:ok, %DProduce{} = d_produce} <- DProduces.create_d_produce(d_produce_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", d_produce_path(conn, :show, d_produce))
      |> render("show.json", d_produce: d_produce)
    end
  end

  def show(conn, %{"id" => id}) do
    d_produce = DProduces.get_d_produce!(id)
    render(conn, "show.json", d_produce: d_produce)
  end

  def update(conn, %{"id" => id, "d_produce" => d_produce_params}) do
    d_produce = DProduces.get_d_produce!(id)

    with {:ok, %DProduce{} = d_produce} <- DProduces.update_d_produce(d_produce, d_produce_params) do
      render(conn, "show.json", d_produce: d_produce)
    end
  end

  def delete(conn, %{"id" => id}) do
    d_produce = DProduces.get_d_produce!(id)
    with {:ok, %DProduce{}} <- DProduces.delete_d_produce(d_produce) do
      send_resp(conn, :no_content, "")
    end
  end
end
