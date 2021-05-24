defmodule Spider.ExportZoneLivestockOrdersTest do
  use Spider.DataCase

  alias Spider.ExportZoneLivestockOrders

  describe "export_zone_livestock_orders" do
    alias Spider.ExportZoneLivestockOrders.ExportZoneLivestockOrder

    @valid_attrs %{dates: "some dates"}
    @update_attrs %{dates: "some updated dates"}
    @invalid_attrs %{dates: nil}

    def export_zone_livestock_order_fixture(attrs \\ %{}) do
      {:ok, export_zone_livestock_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ExportZoneLivestockOrders.create_export_zone_livestock_order()

      export_zone_livestock_order
    end

    test "list_export_zone_livestock_orders/0 returns all export_zone_livestock_orders" do
      export_zone_livestock_order = export_zone_livestock_order_fixture()
      assert ExportZoneLivestockOrders.list_export_zone_livestock_orders() == [export_zone_livestock_order]
    end

    test "get_export_zone_livestock_order!/1 returns the export_zone_livestock_order with given id" do
      export_zone_livestock_order = export_zone_livestock_order_fixture()
      assert ExportZoneLivestockOrders.get_export_zone_livestock_order!(export_zone_livestock_order.id) == export_zone_livestock_order
    end

    test "create_export_zone_livestock_order/1 with valid data creates a export_zone_livestock_order" do
      assert {:ok, %ExportZoneLivestockOrder{} = export_zone_livestock_order} = ExportZoneLivestockOrders.create_export_zone_livestock_order(@valid_attrs)
      assert export_zone_livestock_order.dates == "some dates"
    end

    test "create_export_zone_livestock_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ExportZoneLivestockOrders.create_export_zone_livestock_order(@invalid_attrs)
    end

    test "update_export_zone_livestock_order/2 with valid data updates the export_zone_livestock_order" do
      export_zone_livestock_order = export_zone_livestock_order_fixture()
      assert {:ok, export_zone_livestock_order} = ExportZoneLivestockOrders.update_export_zone_livestock_order(export_zone_livestock_order, @update_attrs)
      assert %ExportZoneLivestockOrder{} = export_zone_livestock_order
      assert export_zone_livestock_order.dates == "some updated dates"
    end

    test "update_export_zone_livestock_order/2 with invalid data returns error changeset" do
      export_zone_livestock_order = export_zone_livestock_order_fixture()
      assert {:error, %Ecto.Changeset{}} = ExportZoneLivestockOrders.update_export_zone_livestock_order(export_zone_livestock_order, @invalid_attrs)
      assert export_zone_livestock_order == ExportZoneLivestockOrders.get_export_zone_livestock_order!(export_zone_livestock_order.id)
    end

    test "delete_export_zone_livestock_order/1 deletes the export_zone_livestock_order" do
      export_zone_livestock_order = export_zone_livestock_order_fixture()
      assert {:ok, %ExportZoneLivestockOrder{}} = ExportZoneLivestockOrders.delete_export_zone_livestock_order(export_zone_livestock_order)
      assert_raise Ecto.NoResultsError, fn -> ExportZoneLivestockOrders.get_export_zone_livestock_order!(export_zone_livestock_order.id) end
    end

    test "change_export_zone_livestock_order/1 returns a export_zone_livestock_order changeset" do
      export_zone_livestock_order = export_zone_livestock_order_fixture()
      assert %Ecto.Changeset{} = ExportZoneLivestockOrders.change_export_zone_livestock_order(export_zone_livestock_order)
    end
  end
end
