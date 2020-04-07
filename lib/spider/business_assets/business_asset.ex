defmodule Spider.BusinessAssets.BusinessAsset do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Businesses.Business

  schema "business_assets" do
    field :asset_name, :string

    belongs_to(:business, Business)

    timestamps()
  end

  @doc false
  def changeset(business_asset, attrs) do
    business_asset
    |> cast(attrs, [:asset_name, :business_id])
    |> validate_required([:asset_name, :business_id])
  end
end
