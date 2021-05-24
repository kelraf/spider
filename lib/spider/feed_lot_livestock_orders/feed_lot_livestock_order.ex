defmodule Spider.FeedLotLivestockOrders.FeedLotLivestockOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.FeedLotBundlers.FeedLotBundler
  alias Spider.LivestockOrderStages.LivestockOrderStage
  alias Spider.LivestockOrders.LivestockOrder

  schema "feed_lot_livestock_orders" do
    field :dates, :map, default: %{}
    field :status, :integer, default: 1

    belongs_to(:feed_lot_bundler, FeedLotBundler)
    belongs_to(:livestock_order_stage, LivestockOrderStage)
    belongs_to(:livestock_order, LivestockOrder)

    timestamps()
  end

  @doc false
  def changeset(feed_lot_livestock_order, attrs) do
    feed_lot_livestock_order
    |> cast(attrs, [:dates, :status, :feed_lot_bundler_id, :livestock_order_stage_id, :livestock_order_id])
    |> validate_required([:dates, :status, :feed_lot_bundler_id, :livestock_order_stage_id, :livestock_order_id])
  end
end
