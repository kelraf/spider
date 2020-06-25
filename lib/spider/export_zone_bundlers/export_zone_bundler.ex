defmodule Spider.ExportZoneBundlers.ExportZoneBundler do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Businesses.Business
  alias Spider.ExportZoneLivestockOrders.ExportZoneLivestockOrder


  schema "export_zone_bundler" do
    field :capacity, :integer
    field :size, :string
    belongs_to(:business, Business)

    has_many(:export_zone_livestock_orders, ExportZoneLivestockOrder)

    timestamps()
  end

  @doc false
  def changeset(export_zone_bundler, attrs) do
    export_zone_bundler
    |> cast(attrs, [:capacity, :size, :business_id])
    |> validate_required([:business_id])
  end
end
