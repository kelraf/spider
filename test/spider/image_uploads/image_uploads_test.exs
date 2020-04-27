defmodule Spider.ImageUploadsTest do
  use Spider.DataCase

  alias Spider.ImageUploads

  describe "imageuploads" do
    alias Spider.ImageUploads.ImageUpload

    @valid_attrs %{image: "some image"}
    @update_attrs %{image: "some updated image"}
    @invalid_attrs %{image: nil}

    def image_upload_fixture(attrs \\ %{}) do
      {:ok, image_upload} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ImageUploads.create_image_upload()

      image_upload
    end

    test "list_imageuploads/0 returns all imageuploads" do
      image_upload = image_upload_fixture()
      assert ImageUploads.list_imageuploads() == [image_upload]
    end

    test "get_image_upload!/1 returns the image_upload with given id" do
      image_upload = image_upload_fixture()
      assert ImageUploads.get_image_upload!(image_upload.id) == image_upload
    end

    test "create_image_upload/1 with valid data creates a image_upload" do
      assert {:ok, %ImageUpload{} = image_upload} = ImageUploads.create_image_upload(@valid_attrs)
      assert image_upload.image == "some image"
    end

    test "create_image_upload/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ImageUploads.create_image_upload(@invalid_attrs)
    end

    test "update_image_upload/2 with valid data updates the image_upload" do
      image_upload = image_upload_fixture()
      assert {:ok, image_upload} = ImageUploads.update_image_upload(image_upload, @update_attrs)
      assert %ImageUpload{} = image_upload
      assert image_upload.image == "some updated image"
    end

    test "update_image_upload/2 with invalid data returns error changeset" do
      image_upload = image_upload_fixture()
      assert {:error, %Ecto.Changeset{}} = ImageUploads.update_image_upload(image_upload, @invalid_attrs)
      assert image_upload == ImageUploads.get_image_upload!(image_upload.id)
    end

    test "delete_image_upload/1 deletes the image_upload" do
      image_upload = image_upload_fixture()
      assert {:ok, %ImageUpload{}} = ImageUploads.delete_image_upload(image_upload)
      assert_raise Ecto.NoResultsError, fn -> ImageUploads.get_image_upload!(image_upload.id) end
    end

    test "change_image_upload/1 returns a image_upload changeset" do
      image_upload = image_upload_fixture()
      assert %Ecto.Changeset{} = ImageUploads.change_image_upload(image_upload)
    end
  end
end
