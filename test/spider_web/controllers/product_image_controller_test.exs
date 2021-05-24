defmodule SpiderWeb.ProductImageControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.ProductsImages
  alias Spider.ProductsImages.ProductImage

  @create_attrs %{uuid: "some uuid"}
  @update_attrs %{uuid: "some updated uuid"}
  @invalid_attrs %{uuid: nil}

  def fixture(:product_image) do
    {:ok, product_image} = ProductsImages.create_product_image(@create_attrs)
    product_image
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all prducts_images", %{conn: conn} do
      conn = get conn, product_image_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product_image" do
    test "renders product_image when data is valid", %{conn: conn} do
      conn = post conn, product_image_path(conn, :create), product_image: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, product_image_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "uuid" => "some uuid"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, product_image_path(conn, :create), product_image: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product_image" do
    setup [:create_product_image]

    test "renders product_image when data is valid", %{conn: conn, product_image: %ProductImage{id: id} = product_image} do
      conn = put conn, product_image_path(conn, :update, product_image), product_image: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, product_image_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "uuid" => "some updated uuid"}
    end

    test "renders errors when data is invalid", %{conn: conn, product_image: product_image} do
      conn = put conn, product_image_path(conn, :update, product_image), product_image: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product_image" do
    setup [:create_product_image]

    test "deletes chosen product_image", %{conn: conn, product_image: product_image} do
      conn = delete conn, product_image_path(conn, :delete, product_image)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, product_image_path(conn, :show, product_image)
      end
    end
  end

  defp create_product_image(_) do
    product_image = fixture(:product_image)
    {:ok, product_image: product_image}
  end
end
