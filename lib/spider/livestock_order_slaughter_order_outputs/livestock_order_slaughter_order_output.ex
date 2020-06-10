defmodule Spider.LivestockOrderSlaughterOrderOutputs.LivestockOrderSlaughterOrderOutput do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.LivestockOrderSlaughterOrders.LivestockOrderSlaughterOrder
  alias Spider.LivestockOrders.LivestockOrder
  alias Spider.LivestockOrderStages.LivestockOrderStage
  alias Spider.LivestockOrderProcessingStages.LivestockOrderProcessingStage


  schema "livestock_order_slaughter_order_outputs" do

    field :output_name, :string
    field :quantity, :integer
    field :status, :integer
    field :units, :string

    belongs_to(:livestock_order_slaughter_order, LivestockOrderSlaughterOrder)
    belongs_to(:livestock_order, LivestockOrder)
    belongs_to(:livestock_order_stage, LivestockOrderStage)
    belongs_to(:livestock_order_processing_stage, LivestockOrderProcessingStage)

    timestamps()
  end

  @doc false
  def changeset(livestock_order_slaughter_order_output, attrs) do
    livestock_order_slaughter_order_output
    |> cast(attrs, [:output_name, :quantity, :units, :status, :livestock_order_slaughter_order_id, :livestock_order_id, :livestock_order_stage_id, :livestock_order_processing_stage_id])
    |> validate_required([:output_name, :quantity, :units, :status, :livestock_order_slaughter_order_id, :livestock_order_id, :livestock_order_stage_id, :livestock_order_processing_stage_id])
  end
end
