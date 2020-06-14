defmodule Spider.LivestockOrderSlaughterOrders.LivestockOrderSlaughterOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.LivestockOrders.LivestockOrder
  alias Spider.LivestockOrderStages.LivestockOrderStage
  alias Spider.LivestockOrderProcessingStages.LivestockOrderProcessingStage
  alias Spider.LivestockOrderSlaughterOrderOutputs.LivestockOrderSlaughterOrderOutput
  alias Spider.Businesses.Business

  schema "livestock_order_slaughter_orders" do

    field :dates, :map, default: %{}
    field :description, :string
    field :status, :integer, default: 1

    belongs_to(:business, Business)
    belongs_to(:livestock_order, LivestockOrder)
    belongs_to(:livestock_order_stage, LivestockOrderStage)
    belongs_to(:livestock_order_processing_stage, LivestockOrderProcessingStage)
    
    has_many(:livestock_order_slaughter_order_outputs, LivestockOrderSlaughterOrderOutput)

    timestamps()
  end

  @doc false
  def changeset(livestock_order_slaughter_order, attrs) do
    livestock_order_slaughter_order
    |> cast(attrs, [:business_id, :status, :description, :dates, :livestock_order_id, :livestock_order_stage_id, :livestock_order_processing_stage_id])
    |> cast_assoc(:livestock_order_slaughter_order_outputs)
    |> validate_required([:business_id, :status, :description, :dates, :livestock_order_id, :livestock_order_stage_id, :livestock_order_processing_stage_id])
  end
end
