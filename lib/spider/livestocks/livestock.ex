defmodule Spider.Livestocks.Livestock do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.DLivestocks.DLivestock


  schema "livestocks" do

    field :quantity, :integer

    belongs_to(:user, User)
    belongs_to(:business, Business)
    belongs_to(:dlivestock, DLivestock)

    timestamps()
  end

  @doc false
  def changeset(livestock, attrs) do
    livestock
    |> cast(attrs, [:dlivestock_id, :quantity, :user_id, :business_id])
    |> validate_required([:dlivestock_id, :quantity, :user_id, :business_id])
  end
end
