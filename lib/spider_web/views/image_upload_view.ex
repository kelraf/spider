defmodule SpiderWeb.ImageUploadView do
  use SpiderWeb, :view
  alias SpiderWeb.ImageUploadView

  def render("index.json", %{imageuploads: imageuploads}) do
    %{data: render_many(imageuploads, ImageUploadView, "image_upload.json")}
  end

  def render("show.json", %{image_upload: image_upload}) do
    %{data: render_one(image_upload, ImageUploadView, "image_upload.json")}
  end

  def render("image_upload.json", %{image_upload: image_upload}) do
    %{id: image_upload.id,
      image: image_upload.image}
  end
end
