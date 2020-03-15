defmodule Spider.OrderContainers.OrderContainer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business

  schema "ordercontainers" do
    
    field :status, :integer, default: 0
    field :total_cost, :integer, default: 0

    belongs_to(:user, User)
    belongs_to(:business, Business)

    timestamps()
  end

  @doc false
  def changeset(order_container, attrs) do
    order_container
    |> cast(attrs, [:status, :total_cost, :user_id, :business_id])
    |> validate_required([:user_id, :business_id])
  end
end
