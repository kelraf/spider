defmodule Spider.BusinessAssets.BusinessAsset do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

    alias Spider.Repo
    alias Spider.Helpers.SpiderData

  alias Spider.Businesses.Business

  schema "business_assets" do
    field :asset_name, :string
    field :status, :integer, default: 2

    belongs_to(:business, Business)

    timestamps()
  end

  @doc false
  def changeset(business_asset, attrs, action \\ "create") do
    business_asset
    |> cast(attrs, [:asset_name, :business_id, :status])
    |> validate_required([:asset_name, :business_id, :status])
    |> validate_one_asset_per_business(action)
  end

  defp validate_one_asset_per_business(changeset, action) do
    case get_field(changeset, :asset_name) do
      nil -> 
        changeset
      asset_name ->

        if action == "update" do
          changeset
        else

            query = from(
                a in __MODULE__,
                where: a.asset_name == ^asset_name,
                select: a
            )

            case Repo.all(query) |> SpiderData.list_empty? do

                false -> 
                    add_error(changeset, :asset_name, "Asset Name Exists")
                true ->
                    changeset
            end
            
        end

    end

  end

end
