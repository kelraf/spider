defmodule SpiderWeb.LivestockSaleControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.LivestockSales
  alias Spider.LivestockSales.LivestockSale

  @create_attrs %{price_per_animal: 42, quantity: 42, total_price: 42}
  @update_attrs %{price_per_animal: 43, quantity: 43, total_price: 43}
  @invalid_attrs %{price_per_animal: nil, quantity: nil, total_price: nil}

  def fixture(:livestock_sale) do
    {:ok, livestock_sale} = LivestockSales.create_livestock_sale(@create_attrs)
    livestock_sale
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all livestock_sales", %{conn: conn} do
      conn = get conn, livestock_sale_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create livestock_sale" do
    test "renders livestock_sale when data is valid", %{conn: conn} do
      conn = post conn, livestock_sale_path(conn, :create), livestock_sale: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, livestock_sale_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "price_per_animal" => 42,
        "quantity" => 42,
        "total_price" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, livestock_sale_path(conn, :create), livestock_sale: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update livestock_sale" do
    setup [:create_livestock_sale]

    test "renders livestock_sale when data is valid", %{conn: conn, livestock_sale: %LivestockSale{id: id} = livestock_sale} do
      conn = put conn, livestock_sale_path(conn, :update, livestock_sale), livestock_sale: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, livestock_sale_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "price_per_animal" => 43,
        "quantity" => 43,
        "total_price" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, livestock_sale: livestock_sale} do
      conn = put conn, livestock_sale_path(conn, :update, livestock_sale), livestock_sale: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete livestock_sale" do
    setup [:create_livestock_sale]

    test "deletes chosen livestock_sale", %{conn: conn, livestock_sale: livestock_sale} do
      conn = delete conn, livestock_sale_path(conn, :delete, livestock_sale)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, livestock_sale_path(conn, :show, livestock_sale)
      end
    end
  end

  defp create_livestock_sale(_) do
    livestock_sale = fixture(:livestock_sale)
    {:ok, livestock_sale: livestock_sale}
  end
end
