defmodule SpiderWeb.ProduceOrderStageController do
  use SpiderWeb, :controller

  alias Spider.ProduceOrderStages
  alias Spider.ProduceOrderStages.ProduceOrderStage
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    produce_order_stages = ProduceOrderStages.list_produce_order_stages()
    render(
      conn, 
      "index.json", 
      produce_order_stages: produce_order_stages
      |> preloader()  
    )
  end

  def create(conn, %{"produce_order_stage" => produce_order_stage_params}) do
    with {:ok, %ProduceOrderStage{} = produce_order_stage} <- ProduceOrderStages.create_produce_order_stage(produce_order_stage_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", produce_order_stage_path(conn, :show, produce_order_stage))
      |> render(
        "show.json", 
        produce_order_stage: produce_order_stage
        |> preloader()  
      )
    end
  end

  def show(conn, %{"id" => id}) do
    produce_order_stage = ProduceOrderStages.get_produce_order_stage!(id)
    render(
      conn, 
      "show.json", 
      produce_order_stage: produce_order_stage
      |> preloader()  
    )
  end

  def update(conn, %{"id" => id, "produce_order_stage" => produce_order_stage_params}) do
    produce_order_stage = ProduceOrderStages.get_produce_order_stage!(id)

    with {:ok, %ProduceOrderStage{} = produce_order_stage} <- ProduceOrderStages.update_produce_order_stage(produce_order_stage, produce_order_stage_params) do
      render(
        conn, 
        "show.json", 
        produce_order_stage: produce_order_stage
        |> preloader()  
      )
    end
  end

  def delete(conn, %{"id" => id}) do
    produce_order_stage = ProduceOrderStages.get_produce_order_stage!(id)
    with {:ok, %ProduceOrderStage{}} <- ProduceOrderStages.delete_produce_order_stage(produce_order_stage) do
      send_resp(conn, :no_content, "")
    end
  end

  defp preloader(resource) do

    resource
    |> Repo.preload([
      produce_center_order: [],
      c_c_p_p_orders: []
    ])

  end

end
