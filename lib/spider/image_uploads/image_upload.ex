defmodule Spider.ImageUploads.ImageUpload do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset


  schema "imageuploads" do
    field :image, Spider.Images.Type
    timestamps()
  end

  @doc false
  def changeset(image_upload, attrs) do
    image_upload
    |> cast(attrs, [:image])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:image])
  end
end
