defmodule Spider.LivestockOrderContainers.LivestockOrderContainer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.Context.LivestockOrderContainer
  alias Spider.Repo

  schema "livestock_order_containers" do
    field(:channel, :string, default: "channel")
    field(:status, :integer, default: 1)
    field(:business_from_id, :integer)
    field(:payment_status, :string, default: "pending")

    belongs_to(:user, User)
    belongs_to(:business, Business)

    has_many(:livestock_orders, Spider.LivestockOrders.LivestockOrder)

    timestamps()
  end

  @doc false
  def changeset(livestock_order_container, attrs, action \\ "create") do
    livestock_order_container
    # |> Repo.preload(:livestock_orders)
    |> cast(attrs, [:status, :payment_status, :business_from_id, :channel, :user_id, :business_id])
    |> cast_assoc(:livestock_orders)
    |> validate_required([:status, :payment_status, :business_from_id, :user_id, :business_id])
    # |> LivestockOrderContainer.check_uncompleted_order_container(action)
  end
  
end
