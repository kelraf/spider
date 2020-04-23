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

    belongs_to(:user, User)
    belongs_to(:business, Business)
    belongs_to(:dlivestock, DLivestock)

    has_many(:tlivestocks, TLivestock)

    timestamps()
  end

  @doc false
  def changeset(livestock, attrs, action \\ "create") do
    livestock
    |> cast(attrs, [:dlivestock_id, :quantity, :user_id, :business_id])
    |> validate_required([:dlivestock_id, :quantity, :user_id, :business_id])
    |> Livestock.validate_one_for_one_business_livestock(action)
  end
end
