defmodule Spider.LivestockOrderSlaughterOrders.LivestockOrderSlaughterOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.LivestockOrders.LivestockOrder
  alias Spider.LivestockOrderStages.LivestockOrderStage
  alias Spider.LivestockOrderProcessingStages.LivestockOrderProcessingStage

  schema "livestock_order_slaughter_orders" do

    field :dates, :map, default: %{}
    field :description, :string
    field :status, :integer, default: 1

    belongs_to(:livestock_order, LivestockOrder)
    belongs_to(:livestock_order_stage, LivestockOrderStage)
    belongs_to(:livestock_order_processing_stage, LivestockOrderProcessingStage)

    timestamps()
  end

  @doc false
  def changeset(livestock_order_slaughter_order, attrs) do
    livestock_order_slaughter_order
    |> cast(attrs, [:status, :description, :dates, :livestock_order_id, :livestock_order_stage_id, :livestock_order_processing_stage_id])
    |> validate_required([:status, :description, :dates, :livestock_order_id, :livestock_order_stage_id, :livestock_order_processing_stage_id])
  end
end
