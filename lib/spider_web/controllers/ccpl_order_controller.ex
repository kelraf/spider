defmodule SpiderWeb.CCPLOrderController do
  use SpiderWeb, :controller

  alias Spider.CCPLOrders
  alias Spider.CCPLOrders.CCPLOrder
  alias Spider.CCPLOrderUploads

  action_fallback(SpiderWeb.FallbackController)

  def index(conn, _params) do
    c_c_p_l_orders = CCPLOrders.list_c_c_p_l_orders()
    render(conn, "index.json", c_c_p_l_orders: c_c_p_l_orders)
  end

  def create(conn, %{
        "file" => ccpl_order_params,
        "livestock_order_stage_id" => livestock_order_stage_id,
        "purpose" => purpose
      }) do
    data = %{
      file: hd(ccpl_order_params),
      purpose: purpose,
      livestock_order_stage_id: livestock_order_stage_id
    }

    with {:ok, %CCPLOrder{} = ccpl_order} <- CCPLOrders.create_ccpl_order(data) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ccpl_order_path(conn, :show, ccpl_order))
      |> render("show.json", ccpl_order: ccpl_order)
    end
  end

  def show(conn, %{"id" => id}) do
    ccpl_order = CCPLOrders.get_ccpl_order!(id)
    render(conn, "show.json", ccpl_order: ccpl_order)
  end

  def update(conn, %{"id" => id, "ccpl_order" => ccpl_order_params}) do
    ccpl_order = CCPLOrders.get_ccpl_order!(id)

    with {:ok, %CCPLOrder{} = ccpl_order} <-
           CCPLOrders.update_ccpl_order(ccpl_order, ccpl_order_params) do
      render(conn, "show.json", ccpl_order: ccpl_order)
    end
  end

  def delete(conn, %{"id" => id}) do
    ccpl_order = CCPLOrders.get_ccpl_order!(id)

    attachment = ccpl_order

    path =
      CCPLOrderUploads.url({attachment.file, attachment})
      |> String.split("?")
      |> List.first()

    Task.start(fn ->
      CCPLOrderUploads.delete({path, attachment})
    end)

    with {:ok, %CCPLOrder{}} <- CCPLOrders.delete_ccpl_order(ccpl_order) do
      send_resp(conn, :no_content, "")
    end
  end
end
