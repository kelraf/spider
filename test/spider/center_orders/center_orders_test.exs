defmodule Spider.CenterOrdersTest do
  use Spider.DataCase

  alias Spider.CenterOrders

  describe "center_orders" do
    alias Spider.CenterOrders.CenterOrder

    @valid_attrs %{available: 42, price_per_animal: "some price_per_animal", required_animals: 42, status: "some status", total_price: "some total_price"}
    @update_attrs %{available: 43, price_per_animal: "some updated price_per_animal", required_animals: 43, status: "some updated status", total_price: "some updated total_price"}
    @invalid_attrs %{available: nil, price_per_animal: nil, required_animals: nil, status: nil, total_price: nil}

    def center_order_fixture(attrs \\ %{}) do
      {:ok, center_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CenterOrders.create_center_order()

      center_order
    end

    test "list_center_orders/0 returns all center_orders" do
      center_order = center_order_fixture()
      assert CenterOrders.list_center_orders() == [center_order]
    end

    test "get_center_order!/1 returns the center_order with given id" do
      center_order = center_order_fixture()
      assert CenterOrders.get_center_order!(center_order.id) == center_order
    end

    test "create_center_order/1 with valid data creates a center_order" do
      assert {:ok, %CenterOrder{} = center_order} = CenterOrders.create_center_order(@valid_attrs)
      assert center_order.available == 42
      assert center_order.price_per_animal == "some price_per_animal"
      assert center_order.required_animals == 42
      assert center_order.status == "some status"
      assert center_order.total_price == "some total_price"
    end

    test "create_center_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CenterOrders.create_center_order(@invalid_attrs)
    end

    test "update_center_order/2 with valid data updates the center_order" do
      center_order = center_order_fixture()
      assert {:ok, center_order} = CenterOrders.update_center_order(center_order, @update_attrs)
      assert %CenterOrder{} = center_order
      assert center_order.available == 43
      assert center_order.price_per_animal == "some updated price_per_animal"
      assert center_order.required_animals == 43
      assert center_order.status == "some updated status"
      assert center_order.total_price == "some updated total_price"
    end

    test "update_center_order/2 with invalid data returns error changeset" do
      center_order = center_order_fixture()
      assert {:error, %Ecto.Changeset{}} = CenterOrders.update_center_order(center_order, @invalid_attrs)
      assert center_order == CenterOrders.get_center_order!(center_order.id)
    end

    test "delete_center_order/1 deletes the center_order" do
      center_order = center_order_fixture()
      assert {:ok, %CenterOrder{}} = CenterOrders.delete_center_order(center_order)
      assert_raise Ecto.NoResultsError, fn -> CenterOrders.get_center_order!(center_order.id) end
    end

    test "change_center_order/1 returns a center_order changeset" do
      center_order = center_order_fixture()
      assert %Ecto.Changeset{} = CenterOrders.change_center_order(center_order)
    end
  end
end
