defmodule Spider.LivestockSales.LivestockSale do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.CenterOrders.CenterOrder
  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.Livestocks.Livestock
  alias Spider.Context.LivestockSales

  schema "livestock_sales" do
    field :price_per_animal, :integer
    field :quantity, :integer
    field :total_price, :integer
    field :current_resource_id, :integer, virtual: true

    belongs_to(:user, User)
    belongs_to(:business, Business)
    belongs_to(:livestock, Livestock)
    belongs_to(:center_order, CenterOrder)

    timestamps()
  end

  @doc false
  def changeset(livestock_sale, attrs, action \\ "create") do
    livestock_sale
    |> cast(attrs, [:quantity, :user_id, :business_id, :livestock_id, :center_order_id, :price_per_animal, :total_price, :current_resource_id])
    |> LivestockSales.process_livestock_sales(action)
    |> validate_required([:quantity, :business_id, :livestock_id, :center_order_id, :price_per_animal, :total_price])
  end
end
