defmodule SpiderWeb.LivestockOrderSlaughterOrderOutputController do
  use SpiderWeb, :controller

  alias Spider.LivestockOrderSlaughterOrderOutputs
  alias Spider.LivestockOrderSlaughterOrderOutputs.LivestockOrderSlaughterOrderOutput

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    livestock_order_slaughter_order_outputs = LivestockOrderSlaughterOrderOutputs.list_livestock_order_slaughter_order_outputs()
    render(conn, "index.json", livestock_order_slaughter_order_outputs: livestock_order_slaughter_order_outputs)
  end

  def create(conn, %{"livestock_order_slaughter_order_output" => livestock_order_slaughter_order_output_params}) do
    with {:ok, %LivestockOrderSlaughterOrderOutput{} = livestock_order_slaughter_order_output} <- LivestockOrderSlaughterOrderOutputs.create_livestock_order_slaughter_order_output(livestock_order_slaughter_order_output_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", livestock_order_slaughter_order_output_path(conn, :show, livestock_order_slaughter_order_output))
      |> render("show.json", livestock_order_slaughter_order_output: livestock_order_slaughter_order_output)
    end
  end

  def show(conn, %{"id" => id}) do
    livestock_order_slaughter_order_output = LivestockOrderSlaughterOrderOutputs.get_livestock_order_slaughter_order_output!(id)
    render(conn, "show.json", livestock_order_slaughter_order_output: livestock_order_slaughter_order_output)
  end

  def update(conn, %{"id" => id, "livestock_order_slaughter_order_output" => livestock_order_slaughter_order_output_params}) do
    livestock_order_slaughter_order_output = LivestockOrderSlaughterOrderOutputs.get_livestock_order_slaughter_order_output!(id)

    with {:ok, %LivestockOrderSlaughterOrderOutput{} = livestock_order_slaughter_order_output} <- LivestockOrderSlaughterOrderOutputs.update_livestock_order_slaughter_order_output(livestock_order_slaughter_order_output, livestock_order_slaughter_order_output_params) do
      render(conn, "show.json", livestock_order_slaughter_order_output: livestock_order_slaughter_order_output)
    end
  end

  def delete(conn, %{"id" => id}) do
    livestock_order_slaughter_order_output = LivestockOrderSlaughterOrderOutputs.get_livestock_order_slaughter_order_output!(id)
    with {:ok, %LivestockOrderSlaughterOrderOutput{}} <- LivestockOrderSlaughterOrderOutputs.delete_livestock_order_slaughter_order_output(livestock_order_slaughter_order_output) do
      send_resp(conn, :no_content, "")
    end
  end
end
