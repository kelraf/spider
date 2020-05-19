defmodule SpiderWeb.DlivestockImageController do
  use SpiderWeb, :controller

  alias Spider.DlivestockImages
  alias Spider.DlivestockImages.DlivestockImage
  alias Spider.DLivestockI 

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    dlivestock_images = DlivestockImages.list_dlivestock_images()
    render(conn, "index.json", dlivestock_images: dlivestock_images)
  end

  def create(conn, %{"d_livestock_image" => dlivestock_image_params, "d_livestock_id" => d_livestock_id}) do

    data = %{
      image: hd(dlivestock_image_params),
      d_livestock_id: d_livestock_id
    }

    with {:ok, %DlivestockImage{} = dlivestock_image} <- DlivestockImages.create_dlivestock_image(data) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", dlivestock_image_path(conn, :show, dlivestock_image))
      |> render("show.json", dlivestock_image: dlivestock_image)
    end
  end

  def show(conn, %{"id" => id}) do
    dlivestock_image = DlivestockImages.get_dlivestock_image!(id)
    render(conn, "show.json", dlivestock_image: dlivestock_image)
  end

  def update(conn, %{"id" => id, "dlivestock_image" => dlivestock_image_params}) do
    dlivestock_image = DlivestockImages.get_dlivestock_image!(id)

    with {:ok, %DlivestockImage{} = dlivestock_image} <- DlivestockImages.update_dlivestock_image(dlivestock_image, dlivestock_image_params) do
      render(conn, "show.json", dlivestock_image: dlivestock_image)
    end
  end

  def delete(conn, %{"id" => id}) do

    dlivestock_image = DlivestockImages.get_dlivestock_image!(id)

    attachment = dlivestock_image

    path = DLivestockI.url({attachment.image, attachment}) |> String.split("?") |> List.first

    Task.start(fn -> 
      DLivestockI.delete({path, attachment})
    end)

    with {:ok, %DlivestockImage{}} <- DlivestockImages.delete_dlivestock_image(dlivestock_image) do
      send_resp(conn, :no_content, "")
    end

  end

end
