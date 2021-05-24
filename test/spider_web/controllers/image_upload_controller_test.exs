defmodule SpiderWeb.ImageUploadControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.ImageUploads
  alias Spider.ImageUploads.ImageUpload

  @create_attrs %{image: "some image"}
  @update_attrs %{image: "some updated image"}
  @invalid_attrs %{image: nil}

  def fixture(:image_upload) do
    {:ok, image_upload} = ImageUploads.create_image_upload(@create_attrs)
    image_upload
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all imageuploads", %{conn: conn} do
      conn = get conn, image_upload_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create image_upload" do
    test "renders image_upload when data is valid", %{conn: conn} do
      conn = post conn, image_upload_path(conn, :create), image_upload: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, image_upload_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "image" => "some image"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, image_upload_path(conn, :create), image_upload: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update image_upload" do
    setup [:create_image_upload]

    test "renders image_upload when data is valid", %{conn: conn, image_upload: %ImageUpload{id: id} = image_upload} do
      conn = put conn, image_upload_path(conn, :update, image_upload), image_upload: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, image_upload_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "image" => "some updated image"}
    end

    test "renders errors when data is invalid", %{conn: conn, image_upload: image_upload} do
      conn = put conn, image_upload_path(conn, :update, image_upload), image_upload: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete image_upload" do
    setup [:create_image_upload]

    test "deletes chosen image_upload", %{conn: conn, image_upload: image_upload} do
      conn = delete conn, image_upload_path(conn, :delete, image_upload)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, image_upload_path(conn, :show, image_upload)
      end
    end
  end

  defp create_image_upload(_) do
    image_upload = fixture(:image_upload)
    {:ok, image_upload: image_upload}
  end
end
