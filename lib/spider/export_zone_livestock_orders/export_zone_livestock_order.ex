defmodule Spider.ExportZoneLivestockOrders.ExportZoneLivestockOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.ExportZoneBundlers.ExportZoneBundler
  alias Spider.LivestockOrderStages.LivestockOrderStage
  alias Spider.LivestockOrders.LivestockOrder

  schema "export_zone_livestock_orders" do
    field :dates, :map, default: %{}

    belongs_to(:export_zone_bundler, ExportZoneBundler)
    belongs_to(:livestock_order_stage, LivestockOrderStage)
    belongs_to(:livestock_order, LivestockOrder)

    timestamps()
  end

  @doc false
  def changeset(export_zone_livestock_order, attrs) do
    export_zone_livestock_order
    |> cast(attrs, [:dates, :export_zone_bundler_id, :livestock_order_stage_id, :livestock_order_id])
    |> validate_required([:dates, :export_zone_bundler_id, :livestock_order_stage_id, :livestock_order_id])
  end
end
