defmodule Spider.FeedLotBundlers.FeedLotBundler do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.FeedLotLivestockOrders.FeedLotLivestockOrder

  schema "feed_lot_bundlers" do
    
    belongs_to(:business, Spider.Businesses.Business)

    has_many(:feed_lot_livestock_orders, FeedLotLivestockOrder)

    timestamps()
  end

  @doc false
  def changeset(feed_lot_bundler, attrs) do
    feed_lot_bundler
    |> cast(attrs, [:business_id])
    |> validate_required([:business_id])
  end
end
