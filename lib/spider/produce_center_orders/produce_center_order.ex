defmodule Spider.ProduceCenterOrders.ProduceCenterOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.ProduceOrders.ProduceOrder
  alias Spider.ProduceOrderStages.ProduceOrderStage
  alias Spider.DProduces.DProduce

  schema "produce_center_orders" do

    field :available_quantity, :integer, default: 0
    field :description, :string
    field :required_quantity, :integer, default: 0
    field :status, :string, default: "offline"
    field :total_cost, :integer, default: 0
    field :who_can_see, {:array, :map}, default: []
    field :dates, :map, default: %{}

    belongs_to(:produce_order, ProduceOrder)
    belongs_to(:produce_order_stage, ProduceOrderStage)
    belongs_to(:d_produce, DProduce)

    timestamps()
  end

  @doc false
  def changeset(produce_center_order, attrs) do
    produce_center_order
    |> cast(attrs, [:required_quantity, :available_quantity, :description, :status, :total_cost, :produce_order_id, :produce_order_stage_id, :d_produce_id, :who_can_see, :dates])
    |> validate_required([:required_quantity, :available_quantity, :status, :total_cost, :produce_order_id, :produce_order_stage_id, :d_produce_id, :who_can_see, :dates])
  end
end
