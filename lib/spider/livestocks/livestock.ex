defmodule Spider.Livestocks.Livestock do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.DLivestocks.DLivestock
  alias Spider.Context.Livestock
  alias Spider.TLivestocks.TLivestock


  schema "livestocks" do

    field :quantity, :integer
    field :price, :integer

    belongs_to(:user, User)
    belongs_to(:business, Business)
    belongs_to(:d_livestock, DLivestock)

    has_many(:tlivestocks, TLivestock)

    timestamps()
  end

  @doc false
  def changeset(livestock, attrs, action \\ "create") do
    livestock
    |> cast(attrs, [:d_livestock_id, :quantity, :price, :user_id, :business_id])
    |> validate_required([:d_livestock_id, :quantity, :price, :user_id, :business_id])
    |> Livestock.validate_min_price()
    |> Livestock.validate_one_for_one_business_livestock(action)
  end
end
