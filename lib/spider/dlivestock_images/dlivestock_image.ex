defmodule Spider.DlivestockImages.DlivestockImage do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Spider.DLivestocks.DLivestock


  schema "dlivestock_images" do
    field :image, Spider.DLivestockI.Type
    field :uuid, :string
    
    belongs_to(:d_livestock, DLivestock)

    timestamps()
  end

  @doc false
  def changeset(dlivestock_image, attrs) do
    dlivestock_image
    |> cast(attrs, [:uuid, :d_livestock_id])
    |> put_change(:uuid, Ecto.UUID.generate)
    |> validate_required([:uuid, :d_livestock_id])
    |> cast_attachments(attrs, [:image])
    |> create_image_name()
  end

  defp create_image_name(changeset) do
    
    case get_field(changeset, :d_livestock_id) do
      nil ->
        changeset
      d_livestock_id ->
        case get_field(changeset, :image) do
          nil -> 
            changeset
          image -> 
            case get_field(changeset, :uuid) do
              nil -> 
                changeset
              uuid ->
                new_image = Map.put(image, :file_name, "spider_#{uuid}_#{d_livestock_id}#{Path.extname(image.file_name)}")
                put_change(changeset, :image, new_image)
            end
        end
    end
  end

end
