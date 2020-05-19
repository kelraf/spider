defmodule Spider.CenterOrders.CenterOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.LivestockOrders.LivestockOrder
  alias Spider.LivestockSales.LivestockSale
  alias Spider.DLivestocks.DLivestock
  alias Spider.Context.CenterOrders

  schema "center_orders" do

    field :available_animals, :integer, default: 0
    field :price_per_animal, :integer, default: 0
    field :required_animals, :integer
    field :status, :string, default: "in-progress"
    field :total_price, :integer, default: 0
    field :total_price_available, :integer, default: 0

    belongs_to(:livestock_order, LivestockOrder)
    belongs_to(:dlivestock, DLivestock)

    has_many(:livestock_sales, LivestockSale)

    timestamps()
  end

  @doc false
  def changeset(center_order, attrs, action \\ "create") do
    center_order
    |> cast(attrs, [:required_animals, :available_animals, :livestock_order_id, :dlivestock_id, :status, :price_per_animal, :total_price, :total_price_available])
    |> validate_required([:required_animals, :available_animals, :livestock_order_id, :dlivestock_id,  :status, :price_per_animal, :total_price, :total_price_available])
    |> CenterOrders.validate_center_order_status()
    |> CenterOrders.validate_one_center_order_for_one_livestock_order(action)
    |> CenterOrders.accumilate_total_price()
  end
end
