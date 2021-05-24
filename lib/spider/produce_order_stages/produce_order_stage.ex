defmodule Spider.ProduceOrderStages.ProduceOrderStage do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.ProduceOrders.ProduceOrder
  alias Spider.ProduceCenterOrders.ProduceCenterOrder
  alias Spider.CCPPOrders.CCPPOrder

  schema "produce_order_stages" do
    field :stage_name, :string
    field :stage_number, :integer
    field :status, :integer, default: 1

    belongs_to(:produce_order, ProduceOrder)
    has_one(:produce_center_order, ProduceCenterOrder)
    has_many(:c_c_p_p_orders, CCPPOrder)

    timestamps()
  end

  @doc false
  def changeset(produce_order_stage, attrs) do
    produce_order_stage
    |> cast(attrs, [:stage_name, :stage_number, :status, :produce_order_id])
    |> validate_required([:stage_name, :stage_number, :status, :produce_order_id])
  end
end
