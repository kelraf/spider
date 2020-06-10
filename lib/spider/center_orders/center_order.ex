defmodule Spider.CenterOrders.CenterOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.LivestockOrders.LivestockOrder
  alias Spider.LivestockSales.LivestockSale
  alias Spider.DLivestocks.DLivestock
  alias Spider.Context.CenterOrders
  alias Spider.LivestockOrderStages.LivestockOrderStage

  schema "center_orders" do
    field(:available_animals, :integer, default: 0)
    field(:price_per_animal, :integer, default: 0)
    field(:required_animals, :integer)
    field(:description, :string)
    field(:status, :string, default: "offline")
    field(:total_price, :integer, default: 0)
    field(:total_price_available, :integer, default: 0)
    field(:who_can_see, {:array, :map}, default: [])

    belongs_to(:livestock_order, LivestockOrder)
    belongs_to(:d_livestock, DLivestock)
    belongs_to(:livestock_order_stage, LivestockOrderStage)

    has_many(:livestock_sales, LivestockSale)

    timestamps()
  end

  @doc false
  def changeset(center_order, attrs, action \\ "create") do
    center_order
    |> cast(attrs, [
      :required_animals,
      :who_can_see,
      :livestock_order_stage_id,
      :available_animals,
      :description,
      :livestock_order_id,
      :d_livestock_id,
      :status,
      :price_per_animal,
      :total_price,
      :total_price_available
    ])
    |> validate_required([
      :required_animals,
      :who_can_see,
      :available_animals,
      :livestock_order_stage_id,
      :livestock_order_id,
      :d_livestock_id,
      :status,
      :price_per_animal,
      :total_price,
      :total_price_available
    ])
    |> CenterOrders.validate_center_order_status()
    # |> CenterOrders.validate_one_center_order_for_one_livestock_order(action)
    |> CenterOrders.accumilate_total_price()
  end
end
