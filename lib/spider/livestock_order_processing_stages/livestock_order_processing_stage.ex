defmodule Spider.LivestockOrderProcessingStages.LivestockOrderProcessingStage do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.LivestockOrders.LivestockOrder
  alias Spider.LivestockOrderStages.LivestockOrderStage

  schema "livestock_order_processing_stages" do
    field :stage_name, :string
    field :status, :integer, default: 1

    belongs_to(:livestock_order, LivestockOrder)
    belongs_to(:livestock_order_stage, LivestockOrderStage)

    timestamps()
  end

  @doc false
  def changeset(livestock_order_processing_stage, attrs) do
    livestock_order_processing_stage
    |> cast(attrs, [:stage_name, :status, :livestock_order_id, :livestock_order_stage_id])
    |> validate_required([:stage_name, :livestock_order_id, :livestock_order_stage_id])
  end
end
