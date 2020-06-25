defmodule SpiderWeb.SlaughterOrderBundlerController do
  use SpiderWeb, :controller

  alias Spider.SlaughterOrderBundlers
  alias Spider.SlaughterOrderBundlers.SlaughterOrderBundler

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    slaughter_order_bundlers = SlaughterOrderBundlers.list_slaughter_order_bundlers()
    render(conn, "index.json", slaughter_order_bundlers: slaughter_order_bundlers)
  end

  def create(conn, %{"slaughter_order_bundler" => slaughter_order_bundler_params}) do
    with {:ok, %SlaughterOrderBundler{} = slaughter_order_bundler} <- SlaughterOrderBundlers.create_slaughter_order_bundler(slaughter_order_bundler_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", slaughter_order_bundler_path(conn, :show, slaughter_order_bundler))
      |> render("show.json", slaughter_order_bundler: slaughter_order_bundler)
    end
  end

  def show(conn, %{"id" => id}) do
    slaughter_order_bundler = SlaughterOrderBundlers.get_slaughter_order_bundler!(id)
    render(conn, "show.json", slaughter_order_bundler: slaughter_order_bundler)
  end

  def update(conn, %{"id" => id, "slaughter_order_bundler" => slaughter_order_bundler_params}) do
    slaughter_order_bundler = SlaughterOrderBundlers.get_slaughter_order_bundler!(id)

    with {:ok, %SlaughterOrderBundler{} = slaughter_order_bundler} <- SlaughterOrderBundlers.update_slaughter_order_bundler(slaughter_order_bundler, slaughter_order_bundler_params) do
      render(conn, "show.json", slaughter_order_bundler: slaughter_order_bundler)
    end
  end

  def delete(conn, %{"id" => id}) do
    slaughter_order_bundler = SlaughterOrderBundlers.get_slaughter_order_bundler!(id)
    with {:ok, %SlaughterOrderBundler{}} <- SlaughterOrderBundlers.delete_slaughter_order_bundler(slaughter_order_bundler) do
      send_resp(conn, :no_content, "")
    end
  end
end
