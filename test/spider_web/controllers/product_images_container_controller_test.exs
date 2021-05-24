defmodule SpiderWeb.ProductImagesContainerControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.ProductImagesContainers
  alias Spider.ProductImagesContainers.ProductImagesContainer

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:product_images_container) do
    {:ok, product_images_container} = ProductImagesContainers.create_product_images_container(@create_attrs)
    product_images_container
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all product_container_images", %{conn: conn} do
      conn = get conn, product_images_container_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product_images_container" do
    test "renders product_images_container when data is valid", %{conn: conn} do
      conn = post conn, product_images_container_path(conn, :create), product_images_container: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, product_images_container_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, product_images_container_path(conn, :create), product_images_container: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product_images_container" do
    setup [:create_product_images_container]

    test "renders product_images_container when data is valid", %{conn: conn, product_images_container: %ProductImagesContainer{id: id} = product_images_container} do
      conn = put conn, product_images_container_path(conn, :update, product_images_container), product_images_container: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, product_images_container_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, product_images_container: product_images_container} do
      conn = put conn, product_images_container_path(conn, :update, product_images_container), product_images_container: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product_images_container" do
    setup [:create_product_images_container]

    test "deletes chosen product_images_container", %{conn: conn, product_images_container: product_images_container} do
      conn = delete conn, product_images_container_path(conn, :delete, product_images_container)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, product_images_container_path(conn, :show, product_images_container)
      end
    end
  end

  defp create_product_images_container(_) do
    product_images_container = fixture(:product_images_container)
    {:ok, product_images_container: product_images_container}
  end
end
