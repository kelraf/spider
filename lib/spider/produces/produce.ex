defmodule Spider.Produces.Produce do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.DProduces.DProduce
  alias Spider.Context.Produce

  schema "produces" do
    field :quantity, :integer

    belongs_to(:user, User)
    belongs_to(:business, Business)
    belongs_to(:dproduce, DProduce)

    timestamps()
  end

  @doc false
  def changeset(produce, attrs, action \\ "create") do
    produce
    |> cast(attrs, [:dproduce_id, :quantity, :user_id, :business_id])
    |> validate_required([:dproduce_id, :quantity, :user_id, :business_id])
    |> Produce.validate_one_for_one_business_produce(action)
  end
end
