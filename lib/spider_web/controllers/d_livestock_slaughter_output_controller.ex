defmodule SpiderWeb.DLivestockSlaughterOutputController do
  use SpiderWeb, :controller

  alias Spider.DLivestockSlaughterOutputs
  alias Spider.DLivestockSlaughterOutputs.DLivestockSlaughterOutput

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    d_livestock_slaughter_outputs = DLivestockSlaughterOutputs.list_d_livestock_slaughter_outputs()
    render(conn, "index.json", d_livestock_slaughter_outputs: d_livestock_slaughter_outputs)
  end

  def get_d_livestock_slaughter_outputs_using_d_livestock_id(conn, %{"d_livestock_id" => d_livestock_id}) do
    
    case DLivestockSlaughterOutputs.get_d_livestock_slaughter_outputs_using_d_livestock_id(d_livestock_id) do
      {:empty, _nonses} ->
        conn
        |> json(%{
          data: [],
          message: "Not Defined"
        })

      {:ok, d_livestock_slaughter_outputs} ->
        conn
        |> render("index.json", d_livestock_slaughter_outputs: d_livestock_slaughter_outputs)
        
    end

  end

  def create(conn, %{"d_livestock_slaughter_output" => d_livestock_slaughter_output_params}) do
    with {:ok, %DLivestockSlaughterOutput{} = d_livestock_slaughter_output} <- DLivestockSlaughterOutputs.create_d_livestock_slaughter_output(d_livestock_slaughter_output_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", d_livestock_slaughter_output_path(conn, :show, d_livestock_slaughter_output))
      |> render("show.json", d_livestock_slaughter_output: d_livestock_slaughter_output)
    end
  end

  def show(conn, %{"id" => id}) do
    d_livestock_slaughter_output = DLivestockSlaughterOutputs.get_d_livestock_slaughter_output!(id)
    render(conn, "show.json", d_livestock_slaughter_output: d_livestock_slaughter_output)
  end

  def update(conn, %{"id" => id, "d_livestock_slaughter_output" => d_livestock_slaughter_output_params}) do
    d_livestock_slaughter_output = DLivestockSlaughterOutputs.get_d_livestock_slaughter_output!(id)

    with {:ok, %DLivestockSlaughterOutput{} = d_livestock_slaughter_output} <- DLivestockSlaughterOutputs.update_d_livestock_slaughter_output(d_livestock_slaughter_output, d_livestock_slaughter_output_params) do
      render(conn, "show.json", d_livestock_slaughter_output: d_livestock_slaughter_output)
    end
  end

  def delete(conn, %{"id" => id}) do
    d_livestock_slaughter_output = DLivestockSlaughterOutputs.get_d_livestock_slaughter_output!(id)
    with {:ok, %DLivestockSlaughterOutput{}} <- DLivestockSlaughterOutputs.delete_d_livestock_slaughter_output(d_livestock_slaughter_output) do
      send_resp(conn, :no_content, "")
    end
  end
end
