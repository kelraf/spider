defmodule Spider.LivestockOrderStages.LivestockOrderStage do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.LivestockOrders.LivestockOrder
  alias Spider.CenterOrders.CenterOrder
  alias Spider.Repo
  alias Spider.CCPLOrders.CCPLOrder
  alias Spider.ExportZoneLivestockOrders.ExportZoneLivestockOrder

  schema "livestock_order_stages" do
    field(:stage_name, :string)
    field(:status, :integer, default: 1)
    # field(:stage_number, )

    belongs_to(:livestock_order, LivestockOrder)

    has_one(:center_order, CenterOrder)
    has_one(:export_zone_livestock_order ,Spider.ExportZoneLivestockOrders.ExportZoneLivestockOrder)
    has_many(:c_c_p_l_orders, CCPLOrder)

    timestamps()
  end

  @doc false
  def changeset(livestock_order_stage, attrs) do
    livestock_order_stage
    |> cast(attrs, [:stage_name, :status, :livestock_order_id])
    |> validate_required([:stage_name, :status])
  end
end
