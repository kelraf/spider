defmodule SpiderWeb.DlivestockImageView do
  use SpiderWeb, :view
  alias SpiderWeb.DlivestockImageView

  def render("index.json", %{dlivestock_images: dlivestock_images}) do
    %{data: render_many(dlivestock_images, DlivestockImageView, "dlivestock_image.json")}
  end

  def render("show.json", %{dlivestock_image: dlivestock_image}) do
    %{data: render_one(dlivestock_image, DlivestockImageView, "dlivestock_image.json")}
  end

  def render("dlivestock_image.json", %{dlivestock_image: dlivestock_image}) do
    %{
      id: dlivestock_image.id,
      uuid: dlivestock_image.uuid,
      image: dlivestock_image.image,
      d_livestock_id: dlivestock_image.d_livestock_id
    }
  end
end
