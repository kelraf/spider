defmodule Spider.DlivestockImagesTest do
  use Spider.DataCase

  alias Spider.DlivestockImages

  describe "dlivestock_images" do
    alias Spider.DlivestockImages.DlivestockImage

    @valid_attrs %{uuid: "some uuid"}
    @update_attrs %{uuid: "some updated uuid"}
    @invalid_attrs %{uuid: nil}

    def dlivestock_image_fixture(attrs \\ %{}) do
      {:ok, dlivestock_image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DlivestockImages.create_dlivestock_image()

      dlivestock_image
    end

    test "list_dlivestock_images/0 returns all dlivestock_images" do
      dlivestock_image = dlivestock_image_fixture()
      assert DlivestockImages.list_dlivestock_images() == [dlivestock_image]
    end

    test "get_dlivestock_image!/1 returns the dlivestock_image with given id" do
      dlivestock_image = dlivestock_image_fixture()
      assert DlivestockImages.get_dlivestock_image!(dlivestock_image.id) == dlivestock_image
    end

    test "create_dlivestock_image/1 with valid data creates a dlivestock_image" do
      assert {:ok, %DlivestockImage{} = dlivestock_image} = DlivestockImages.create_dlivestock_image(@valid_attrs)
      assert dlivestock_image.uuid == "some uuid"
    end

    test "create_dlivestock_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DlivestockImages.create_dlivestock_image(@invalid_attrs)
    end

    test "update_dlivestock_image/2 with valid data updates the dlivestock_image" do
      dlivestock_image = dlivestock_image_fixture()
      assert {:ok, dlivestock_image} = DlivestockImages.update_dlivestock_image(dlivestock_image, @update_attrs)
      assert %DlivestockImage{} = dlivestock_image
      assert dlivestock_image.uuid == "some updated uuid"
    end

    test "update_dlivestock_image/2 with invalid data returns error changeset" do
      dlivestock_image = dlivestock_image_fixture()
      assert {:error, %Ecto.Changeset{}} = DlivestockImages.update_dlivestock_image(dlivestock_image, @invalid_attrs)
      assert dlivestock_image == DlivestockImages.get_dlivestock_image!(dlivestock_image.id)
    end

    test "delete_dlivestock_image/1 deletes the dlivestock_image" do
      dlivestock_image = dlivestock_image_fixture()
      assert {:ok, %DlivestockImage{}} = DlivestockImages.delete_dlivestock_image(dlivestock_image)
      assert_raise Ecto.NoResultsError, fn -> DlivestockImages.get_dlivestock_image!(dlivestock_image.id) end
    end

    test "change_dlivestock_image/1 returns a dlivestock_image changeset" do
      dlivestock_image = dlivestock_image_fixture()
      assert %Ecto.Changeset{} = DlivestockImages.change_dlivestock_image(dlivestock_image)
    end
  end
end
