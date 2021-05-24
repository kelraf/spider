defmodule Spider.LivestockOrderSlaughterOrderOutputs.LivestockOrderSlaughterOrderOutput do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.LivestockOrderSlaughterOrders.LivestockOrderSlaughterOrder
  alias Spider.LivestockOrders.LivestockOrder
  alias Spider.LivestockOrderStages.LivestockOrderStage
  alias Spider.LivestockOrderProcessingStages.LivestockOrderProcessingStage
  alias Spider.DLivestockSlaughterOutputs.DLivestockSlaughterOutput


  schema "livestock_order_slaughter_order_outputs" do

    field :quantity, :integer
    field :status, :integer, default: 1

    belongs_to(:livestock_order_slaughter_order, LivestockOrderSlaughterOrder)
    belongs_to(:livestock_order, LivestockOrder)
    belongs_to(:livestock_order_stage, LivestockOrderStage)
    belongs_to(:livestock_order_processing_stage, LivestockOrderProcessingStage)
    belongs_to(:d_livestock_slaughter_output, DLivestockSlaughterOutput)

    timestamps()
  end

  @doc false
  def changeset(livestock_order_slaughter_order_output, attrs) do
    livestock_order_slaughter_order_output
    |> cast(attrs, [:quantity, :status, :livestock_order_slaughter_order_id, :livestock_order_id, :livestock_order_stage_id, :livestock_order_processing_stage_id, :d_livestock_slaughter_output_id])
    |> validate_required([:status, :livestock_order_id, :livestock_order_stage_id, :livestock_order_processing_stage_id, :d_livestock_slaughter_output_id])
  end
end
