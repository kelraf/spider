defmodule Spider.ProduceOrderContainers.ProduceOrderContainer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business

  schema "produce_order_containers" do

    field :business_from_id, :integer
    field :channel, :string, default: "channel"
    field :payment_status, :string, default: "pending"
    field :status, :integer, default: 1

    belongs_to(:user, User)
    belongs_to(:business, Business)

    has_many(:produce_orders, Spider.ProduceOrders.ProduceOrder)

    timestamps()
  end

  @doc false
  def changeset(produce_order_container, attrs) do
    produce_order_container
    |> cast(attrs, [:channel, :status, :business_from_id, :payment_status, :user_id, :business_id])
    |> cast_assoc(:produce_orders)
    |> validate_required([:channel, :status, :business_from_id, :payment_status, :user_id, :business_id])
  end
end
