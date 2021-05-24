defmodule Spider.ProductImagesContainersTest do
  use Spider.DataCase

  alias Spider.ProductImagesContainers

  describe "product_container_images" do
    alias Spider.ProductImagesContainers.ProductImagesContainer

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def product_images_container_fixture(attrs \\ %{}) do
      {:ok, product_images_container} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProductImagesContainers.create_product_images_container()

      product_images_container
    end

    test "list_product_container_images/0 returns all product_container_images" do
      product_images_container = product_images_container_fixture()
      assert ProductImagesContainers.list_product_container_images() == [product_images_container]
    end

    test "get_product_images_container!/1 returns the product_images_container with given id" do
      product_images_container = product_images_container_fixture()
      assert ProductImagesContainers.get_product_images_container!(product_images_container.id) == product_images_container
    end

    test "create_product_images_container/1 with valid data creates a product_images_container" do
      assert {:ok, %ProductImagesContainer{} = product_images_container} = ProductImagesContainers.create_product_images_container(@valid_attrs)
    end

    test "create_product_images_container/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductImagesContainers.create_product_images_container(@invalid_attrs)
    end

    test "update_product_images_container/2 with valid data updates the product_images_container" do
      product_images_container = product_images_container_fixture()
      assert {:ok, product_images_container} = ProductImagesContainers.update_product_images_container(product_images_container, @update_attrs)
      assert %ProductImagesContainer{} = product_images_container
    end

    test "update_product_images_container/2 with invalid data returns error changeset" do
      product_images_container = product_images_container_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductImagesContainers.update_product_images_container(product_images_container, @invalid_attrs)
      assert product_images_container == ProductImagesContainers.get_product_images_container!(product_images_container.id)
    end

    test "delete_product_images_container/1 deletes the product_images_container" do
      product_images_container = product_images_container_fixture()
      assert {:ok, %ProductImagesContainer{}} = ProductImagesContainers.delete_product_images_container(product_images_container)
      assert_raise Ecto.NoResultsError, fn -> ProductImagesContainers.get_product_images_container!(product_images_container.id) end
    end

    test "change_product_images_container/1 returns a product_images_container changeset" do
      product_images_container = product_images_container_fixture()
      assert %Ecto.Changeset{} = ProductImagesContainers.change_product_images_container(product_images_container)
    end
  end
end
