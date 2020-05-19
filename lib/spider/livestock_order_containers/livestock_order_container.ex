defmodule Spider.LivestockOrderContainers.LivestockOrderContainer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.Context.LivestockOrderContainer


  schema "livestock_order_containers" do

    field :channel, :string
    field :status, :integer, default: 1
    field :total_cost, :integer, default: 0
    field :to_add_or_delete, :integer, virtual: true
    field :payment_status, :string, default: "pending"

    belongs_to(:user, User)
    belongs_to(:business, Business)

    has_many(:livestock_orders, Spider.LivestockOrders.LivestockOrder)

    timestamps()
  end

  @doc false
  def changeset(livestock_order_container, attrs, action \\ "create") do
    livestock_order_container
    |> cast(attrs, [:status, :total_cost, :to_add_or_delete, :channel, :payment_status, :user_id, :business_id])
    |> validate_required([:status, :total_cost, :payment_status, :user_id, :business_id])
    |> LivestockOrderContainer.check_uncompleted_order_container(action)
  end
end
