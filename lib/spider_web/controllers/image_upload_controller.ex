defmodule SpiderWeb.ImageUploadController do
  use SpiderWeb, :controller

  alias Spider.ImageUploads
  alias Spider.ImageUploads.ImageUpload

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    imageuploads = ImageUploads.list_imageuploads()
    render(conn, "index.json", imageuploads: imageuploads)
  end

  def create(conn, %{"image_upload" => image_upload_params}) do
    [head | _] = image_upload_params
    

    with {:ok, %ImageUpload{} = image_upload} <- ImageUploads.create_image_upload(%{image: head}) do # [head | _]
      conn
      |> put_status(:created)
      |> put_resp_header("location", image_upload_path(conn, :show, image_upload))
      |> render("show.json", image_upload: image_upload)
    end
  end

  def show(conn, %{"id" => id}) do
    image_upload = ImageUploads.get_image_upload!(id)
    render(conn, "show.json", image_upload: image_upload)
  end

  def update(conn, %{"id" => id, "image_upload" => image_upload_params}) do
    image_upload = ImageUploads.get_image_upload!(id)

    with {:ok, %ImageUpload{} = image_upload} <- ImageUploads.update_image_upload(image_upload, image_upload_params) do
      render(conn, "show.json", image_upload: image_upload)
    end
  end

  def delete(conn, %{"id" => id}) do
    image_upload = ImageUploads.get_image_upload!(id)
    with {:ok, %ImageUpload{}} <- ImageUploads.delete_image_upload(image_upload) do
      send_resp(conn, :no_content, "")
    end
  end
end
