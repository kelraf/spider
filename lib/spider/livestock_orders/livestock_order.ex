defmodule Spider.LivestockOrders.LivestockOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.LivestockOrderContainers.LivestockOrderContainer
  alias Spider.Livestocks.Livestock
  alias Spider.DLivestocks.DLivestock
  alias Spider.Context.LivestockOrder
  alias Spider.CenterOrders.CenterOrder


  schema "livestock_orders" do

    field :price, :integer
    field :quantity, :integer
    field :total_cost, :integer

    belongs_to(:livestock_order_container, LivestockOrderContainer)
    belongs_to(:dlivestock, DLivestock)

    has_one(:center_order, CenterOrder)

    timestamps()
  end

  @doc false
  def changeset(livestock_order, attrs, action \\ "create") do
    livestock_order
    |> cast(attrs, [:price, :total_cost, :quantity, :livestock_order_container_id, :dlivestock_id])
    |> validate_required([:price, :quantity, :livestock_order_container_id, :dlivestock_id])
    |> LivestockOrder.validate_one_animal_type_per_container(action)
    |> LivestockOrder.accumilate_total_cost()
  end
end
