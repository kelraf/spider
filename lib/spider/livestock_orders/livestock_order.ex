defmodule Spider.LivestockOrders.LivestockOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.LivestockOrderContainers.LivestockOrderContainer
  alias Spider.Livestocks.Livestock
  alias Spider.DLivestocks.DLivestock
  alias Spider.Context.LivestockOrder
  alias Spider.LivestockOrderStages.LivestockOrderStage
  alias Spider.Repo


  schema "livestock_orders" do

    field :price, :integer
    field :quantity, :integer
    field :total_cost, :integer

    belongs_to(:livestock_order_container, LivestockOrderContainer)
    belongs_to(:d_livestock, DLivestock)

    has_many(:livestock_order_stages, LivestockOrderStage)

    timestamps()
  end

  @doc false
  def changeset(livestock_order, attrs, action \\ "create") do
    livestock_order
    # |> Repo.preload(:livestock_order_stages)
    |> cast(attrs, [:price, :total_cost, :quantity, :livestock_order_container_id, :d_livestock_id])
    |> cast_assoc(:livestock_order_stages)
    |> validate_required([:price, :quantity, :d_livestock_id])
    |> LivestockOrder.validate_one_animal_type_per_container(action)
    |> LivestockOrder.accumilate_total_cost()
  end
end
