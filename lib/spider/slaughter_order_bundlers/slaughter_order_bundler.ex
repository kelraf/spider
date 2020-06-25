defmodule Spider.SlaughterOrderBundlers.SlaughterOrderBundler do
  use Ecto.Schema
  import Ecto.Changeset


  schema "slaughter_order_bundlers" do

    belongs_to(:business, Spider.Businesses.Business)

    timestamps()
  end

  @doc false
  def changeset(slaughter_order_bundler, attrs) do
    slaughter_order_bundler
    |> cast(attrs, [:business_id])
    |> validate_required([:business_id])
  end
end
