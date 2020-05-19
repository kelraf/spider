defmodule Spider.LivestockSalesTest do
  use Spider.DataCase

  alias Spider.LivestockSales

  describe "livestock_sales" do
    alias Spider.LivestockSales.LivestockSale

    @valid_attrs %{price_per_animal: 42, quantity: 42, total_price: 42}
    @update_attrs %{price_per_animal: 43, quantity: 43, total_price: 43}
    @invalid_attrs %{price_per_animal: nil, quantity: nil, total_price: nil}

    def livestock_sale_fixture(attrs \\ %{}) do
      {:ok, livestock_sale} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LivestockSales.create_livestock_sale()

      livestock_sale
    end

    test "list_livestock_sales/0 returns all livestock_sales" do
      livestock_sale = livestock_sale_fixture()
      assert LivestockSales.list_livestock_sales() == [livestock_sale]
    end

    test "get_livestock_sale!/1 returns the livestock_sale with given id" do
      livestock_sale = livestock_sale_fixture()
      assert LivestockSales.get_livestock_sale!(livestock_sale.id) == livestock_sale
    end

    test "create_livestock_sale/1 with valid data creates a livestock_sale" do
      assert {:ok, %LivestockSale{} = livestock_sale} = LivestockSales.create_livestock_sale(@valid_attrs)
      assert livestock_sale.price_per_animal == 42
      assert livestock_sale.quantity == 42
      assert livestock_sale.total_price == 42
    end

    test "create_livestock_sale/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LivestockSales.create_livestock_sale(@invalid_attrs)
    end

    test "update_livestock_sale/2 with valid data updates the livestock_sale" do
      livestock_sale = livestock_sale_fixture()
      assert {:ok, livestock_sale} = LivestockSales.update_livestock_sale(livestock_sale, @update_attrs)
      assert %LivestockSale{} = livestock_sale
      assert livestock_sale.price_per_animal == 43
      assert livestock_sale.quantity == 43
      assert livestock_sale.total_price == 43
    end

    test "update_livestock_sale/2 with invalid data returns error changeset" do
      livestock_sale = livestock_sale_fixture()
      assert {:error, %Ecto.Changeset{}} = LivestockSales.update_livestock_sale(livestock_sale, @invalid_attrs)
      assert livestock_sale == LivestockSales.get_livestock_sale!(livestock_sale.id)
    end

    test "delete_livestock_sale/1 deletes the livestock_sale" do
      livestock_sale = livestock_sale_fixture()
      assert {:ok, %LivestockSale{}} = LivestockSales.delete_livestock_sale(livestock_sale)
      assert_raise Ecto.NoResultsError, fn -> LivestockSales.get_livestock_sale!(livestock_sale.id) end
    end

    test "change_livestock_sale/1 returns a livestock_sale changeset" do
      livestock_sale = livestock_sale_fixture()
      assert %Ecto.Changeset{} = LivestockSales.change_livestock_sale(livestock_sale)
    end
  end
end
