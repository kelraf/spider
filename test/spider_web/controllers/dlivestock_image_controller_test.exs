defmodule SpiderWeb.DlivestockImageControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.DlivestockImages
  alias Spider.DlivestockImages.DlivestockImage

  @create_attrs %{uuid: "some uuid"}
  @update_attrs %{uuid: "some updated uuid"}
  @invalid_attrs %{uuid: nil}

  def fixture(:dlivestock_image) do
    {:ok, dlivestock_image} = DlivestockImages.create_dlivestock_image(@create_attrs)
    dlivestock_image
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all dlivestock_images", %{conn: conn} do
      conn = get conn, dlivestock_image_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create dlivestock_image" do
    test "renders dlivestock_image when data is valid", %{conn: conn} do
      conn = post conn, dlivestock_image_path(conn, :create), dlivestock_image: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, dlivestock_image_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "uuid" => "some uuid"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, dlivestock_image_path(conn, :create), dlivestock_image: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update dlivestock_image" do
    setup [:create_dlivestock_image]

    test "renders dlivestock_image when data is valid", %{conn: conn, dlivestock_image: %DlivestockImage{id: id} = dlivestock_image} do
      conn = put conn, dlivestock_image_path(conn, :update, dlivestock_image), dlivestock_image: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, dlivestock_image_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "uuid" => "some updated uuid"}
    end

    test "renders errors when data is invalid", %{conn: conn, dlivestock_image: dlivestock_image} do
      conn = put conn, dlivestock_image_path(conn, :update, dlivestock_image), dlivestock_image: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete dlivestock_image" do
    setup [:create_dlivestock_image]

    test "deletes chosen dlivestock_image", %{conn: conn, dlivestock_image: dlivestock_image} do
      conn = delete conn, dlivestock_image_path(conn, :delete, dlivestock_image)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, dlivestock_image_path(conn, :show, dlivestock_image)
      end
    end
  end

  defp create_dlivestock_image(_) do
    dlivestock_image = fixture(:dlivestock_image)
    {:ok, dlivestock_image: dlivestock_image}
  end
end
