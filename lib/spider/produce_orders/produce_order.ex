defmodule Spider.ProduceOrders.ProduceOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.ProduceOrderContainers.ProduceOrderContainer
  alias Spider.DProduces.DProduce
  alias Spider.Context.ProduceOrders
  alias Spider.ProduceOrderStages.ProduceOrderStage

  schema "produce_orders" do

    field :price_per_unit, :integer
    field :quantity, :integer
    field :total_cost, :integer

    belongs_to(:produce_order_container, ProduceOrderContainer)
    belongs_to(:d_produce, DProduce)

    has_many(:produce_order_stages, ProduceOrderStage)

    timestamps()

  end

  @doc false
  def changeset(produce_order, attrs) do
    produce_order
    |> cast(attrs, [:price_per_unit, :quantity, :total_cost, :d_produce_id])
    |> ProduceOrders.calc_total_cost()
    |> validate_required([:price_per_unit, :quantity, :total_cost, :d_produce_id])
  end
end
