defmodule Spider.ProductsImagesTest do
  use Spider.DataCase

  alias Spider.ProductsImages

  describe "prducts_images" do
    alias Spider.ProductsImages.ProductImage

    @valid_attrs %{uuid: "some uuid"}
    @update_attrs %{uuid: "some updated uuid"}
    @invalid_attrs %{uuid: nil}

    def product_image_fixture(attrs \\ %{}) do
      {:ok, product_image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProductsImages.create_product_image()

      product_image
    end

    test "list_prducts_images/0 returns all prducts_images" do
      product_image = product_image_fixture()
      assert ProductsImages.list_prducts_images() == [product_image]
    end

    test "get_product_image!/1 returns the product_image with given id" do
      product_image = product_image_fixture()
      assert ProductsImages.get_product_image!(product_image.id) == product_image
    end

    test "create_product_image/1 with valid data creates a product_image" do
      assert {:ok, %ProductImage{} = product_image} = ProductsImages.create_product_image(@valid_attrs)
      assert product_image.uuid == "some uuid"
    end

    test "create_product_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductsImages.create_product_image(@invalid_attrs)
    end

    test "update_product_image/2 with valid data updates the product_image" do
      product_image = product_image_fixture()
      assert {:ok, product_image} = ProductsImages.update_product_image(product_image, @update_attrs)
      assert %ProductImage{} = product_image
      assert product_image.uuid == "some updated uuid"
    end

    test "update_product_image/2 with invalid data returns error changeset" do
      product_image = product_image_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductsImages.update_product_image(product_image, @invalid_attrs)
      assert product_image == ProductsImages.get_product_image!(product_image.id)
    end

    test "delete_product_image/1 deletes the product_image" do
      product_image = product_image_fixture()
      assert {:ok, %ProductImage{}} = ProductsImages.delete_product_image(product_image)
      assert_raise Ecto.NoResultsError, fn -> ProductsImages.get_product_image!(product_image.id) end
    end

    test "change_product_image/1 returns a product_image changeset" do
      product_image = product_image_fixture()
      assert %Ecto.Changeset{} = ProductsImages.change_product_image(product_image)
    end
  end
end
