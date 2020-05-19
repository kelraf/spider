defmodule Spider.DLivestocks.DLivestock do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Spider.DlivestockImages.DlivestockImage
  alias Spider.Helpers.SpiderData
  alias Spider.Livestocks.Livestock


  schema "dlivestock" do
    field :breed, :string
    field :category, :string
    field :reference, :string
    field :type, :string

    has_many(:d_livestock_images, DlivestockImage)
    has_many(:livestocks, Livestock)

    timestamps()
  end

  @doc false
  def changeset(d_livestock, attrs) do
    d_livestock
    |> cast(attrs, [:reference, :type, :breed, :category])
    |> validate_required([:category, :type])
  end

  def join_images(id) do
    query = from(
      dl in __MODULE__,
      where: dl.id == ^id,
      left_join: dli in DlivestockImage,
      on: dli.dlivestock_id == dl.id,
      select: {dl, dli}
    )
  end

  def process_join_images(join_images_results) do

    case join_images_results |> SpiderData.list_empty? do
      true ->
        {:error, "Empty"}
      false ->

        case join_images_results do
          {dlivestocks, nil} ->

            Map.put(dlivestocks, :dlivestock_images, [])
            
          {dlivestocks, dlivestocks_images} ->
            Map.put(dlivestocks, :dlivestock_images, dlivestocks_images)
        end

    end

  end
end
