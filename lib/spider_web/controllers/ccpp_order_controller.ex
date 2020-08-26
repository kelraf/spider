defmodule SpiderWeb.CCPPOrderController do
  use SpiderWeb, :controller

  alias Spider.CCPPOrders
  alias Spider.CCPPOrders.CCPPOrder
  alias Spider.CCPPOrderUploads

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    c_c_p_p_orders = CCPPOrders.list_c_c_p_p_orders()
    render(conn, "index.json", c_c_p_p_orders: c_c_p_p_orders)
  end

  def create(conn, %{
      "file" => ccpp_order_params,
      "produce_order_stage_id" => produce_order_stage_id,
      "purpose" => purpose
    }) do

      data = %{
        file: hd(ccpp_order_params),
        purpose: purpose,
        produce_order_stage_id: produce_order_stage_id
      }

    with {:ok, %CCPPOrder{} = ccpp_order} <- CCPPOrders.create_ccpp_order(data) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ccpp_order_path(conn, :show, ccpp_order))
      |> render("show.json", ccpp_order: ccpp_order)
    end
  end

  def show(conn, %{"id" => id}) do
    ccpp_order = CCPPOrders.get_ccpp_order!(id)
    render(conn, "show.json", ccpp_order: ccpp_order)
  end

  def update(conn, %{"id" => id, "ccpp_order" => ccpp_order_params}) do
    ccpp_order = CCPPOrders.get_ccpp_order!(id)

    with {:ok, %CCPPOrder{} = ccpp_order} <- CCPPOrders.update_ccpp_order(ccpp_order, ccpp_order_params) do
      render(conn, "show.json", ccpp_order: ccpp_order)
    end
  end

  def delete(conn, %{"id" => id}) do
    ccpp_order = CCPPOrders.get_ccpp_order!(id)

    attachment = ccpp_order

    path =
      CCPPOrderUploads.url({attachment.file, attachment})
      |> String.split("?")
      |> List.first()

    Task.start(fn ->
      CCPPOrderUploads.delete({path, attachment})
    end)

    with {:ok, %CCPPOrder{}} <- CCPPOrders.delete_ccpp_order(ccpp_order) do
      send_resp(conn, :no_content, "")
    end
  end
end
