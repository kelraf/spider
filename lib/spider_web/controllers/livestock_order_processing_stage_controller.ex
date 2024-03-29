defmodule SpiderWeb.LivestockOrderProcessingStageController do
  use SpiderWeb, :controller

  alias Spider.LivestockOrderProcessingStages
  alias Spider.LivestockOrderProcessingStages.LivestockOrderProcessingStage
  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    livestock_order_processing_stages = LivestockOrderProcessingStages.list_livestock_order_processing_stages()
    render(
      conn, 
      "index.json", 
      livestock_order_processing_stages: livestock_order_processing_stages
      |> preloader
    )
  end

  def create(conn, %{"livestock_order_processing_stage" => livestock_order_processing_stage_params}) do
    with {:ok, %LivestockOrderProcessingStage{} = livestock_order_processing_stage} <- LivestockOrderProcessingStages.create_livestock_order_processing_stage(livestock_order_processing_stage_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", livestock_order_processing_stage_path(conn, :show, livestock_order_processing_stage))
      |> render(
        "show.json", 
        livestock_order_processing_stage: livestock_order_processing_stage 
        |> preloader 
      )
    end
  end

  def show(conn, %{"id" => id}) do
    livestock_order_processing_stage = LivestockOrderProcessingStages.get_livestock_order_processing_stage!(id)
    render(
      conn, 
      "show.json", 
      livestock_order_processing_stage: livestock_order_processing_stage
      |> preloader
    )
  end

  def update(conn, %{"id" => id, "livestock_order_processing_stage" => livestock_order_processing_stage_params}) do
    livestock_order_processing_stage = LivestockOrderProcessingStages.get_livestock_order_processing_stage!(id)

    with {:ok, %LivestockOrderProcessingStage{} = livestock_order_processing_stage} <- LivestockOrderProcessingStages.update_livestock_order_processing_stage(livestock_order_processing_stage, livestock_order_processing_stage_params) do
      render(
        conn, 
        "show.json", 
        livestock_order_processing_stage: livestock_order_processing_stage 
        |> preloader
      )
    end
  end

  def delete(conn, %{"id" => id}) do
    livestock_order_processing_stage = LivestockOrderProcessingStages.get_livestock_order_processing_stage!(id)
    with {:ok, %LivestockOrderProcessingStage{}} <- LivestockOrderProcessingStages.delete_livestock_order_processing_stage(livestock_order_processing_stage) do
      send_resp(conn, :no_content, "")
    end
  end

  defp preloader(resource) do

    resource
    |> Repo.preload(
        [
          livestock_order_slaughter_orders: [
            livestock_order_slaughter_order_outputs: [
              d_livestock_slaughter_output: []
            ],
            business: [
              business_assets: [],
              user: []
            ],
            livestock_order: [
              d_livestock: [
                d_livestock_images: []
              ]
            ]
          ]
        ]
    )
    
  end

end
