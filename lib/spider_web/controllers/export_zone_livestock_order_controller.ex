defmodule SpiderWeb.ExportZoneLivestockOrderController do
  use SpiderWeb, :controller

  alias Spider.ExportZoneLivestockOrders
  alias Spider.ExportZoneLivestockOrders.ExportZoneLivestockOrder
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    export_zone_livestock_orders = ExportZoneLivestockOrders.list_export_zone_livestock_orders() |> Repo.preload([export_zone_bundler: [business: [business_assets: [], user: []]]])
    render(conn, "index.json", export_zone_livestock_orders: export_zone_livestock_orders)
  end

  def create(conn, %{"export_zone_livestock_order" => export_zone_livestock_order_params}) do
    with {:ok, %ExportZoneLivestockOrder{} = export_zone_livestock_order} <- ExportZoneLivestockOrders.create_export_zone_livestock_order(export_zone_livestock_order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", export_zone_livestock_order_path(conn, :show, export_zone_livestock_order))
      |> render("show.json", export_zone_livestock_order: export_zone_livestock_order |> Repo.preload([export_zone_bundler: [business: [business_assets: [], user: []]]]))
    end
  end

  def show(conn, %{"id" => id}) do
    export_zone_livestock_order = ExportZoneLivestockOrders.get_export_zone_livestock_order!(id)
    render(conn, "show.json", export_zone_livestock_order: export_zone_livestock_order |> Repo.preload([export_zone_bundler: [business: [business_assets: [], user: []]]]))
  end

  def update(conn, %{"id" => id, "export_zone_livestock_order" => export_zone_livestock_order_params}) do
    export_zone_livestock_order = ExportZoneLivestockOrders.get_export_zone_livestock_order!(id)

    with {:ok, %ExportZoneLivestockOrder{} = export_zone_livestock_order} <- ExportZoneLivestockOrders.update_export_zone_livestock_order(export_zone_livestock_order, export_zone_livestock_order_params) do
      render(conn, "show.json", export_zone_livestock_order: export_zone_livestock_order |> Repo.preload([export_zone_bundler: [business: [business_assets: [], user: []]]]))
    end
  end

  def delete(conn, %{"id" => id}) do
    export_zone_livestock_order = ExportZoneLivestockOrders.get_export_zone_livestock_order!(id)
    with {:ok, %ExportZoneLivestockOrder{}} <- ExportZoneLivestockOrders.delete_export_zone_livestock_order(export_zone_livestock_order) do
      send_resp(conn, :no_content, "")
    end
  end
end
