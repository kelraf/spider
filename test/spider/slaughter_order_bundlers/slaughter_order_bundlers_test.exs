defmodule Spider.SlaughterOrderBundlersTest do
  use Spider.DataCase

  alias Spider.SlaughterOrderBundlers

  describe "slaughter_order_bundlers" do
    alias Spider.SlaughterOrderBundlers.SlaughterOrderBundler

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def slaughter_order_bundler_fixture(attrs \\ %{}) do
      {:ok, slaughter_order_bundler} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SlaughterOrderBundlers.create_slaughter_order_bundler()

      slaughter_order_bundler
    end

    test "list_slaughter_order_bundlers/0 returns all slaughter_order_bundlers" do
      slaughter_order_bundler = slaughter_order_bundler_fixture()
      assert SlaughterOrderBundlers.list_slaughter_order_bundlers() == [slaughter_order_bundler]
    end

    test "get_slaughter_order_bundler!/1 returns the slaughter_order_bundler with given id" do
      slaughter_order_bundler = slaughter_order_bundler_fixture()
      assert SlaughterOrderBundlers.get_slaughter_order_bundler!(slaughter_order_bundler.id) == slaughter_order_bundler
    end

    test "create_slaughter_order_bundler/1 with valid data creates a slaughter_order_bundler" do
      assert {:ok, %SlaughterOrderBundler{} = slaughter_order_bundler} = SlaughterOrderBundlers.create_slaughter_order_bundler(@valid_attrs)
    end

    test "create_slaughter_order_bundler/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SlaughterOrderBundlers.create_slaughter_order_bundler(@invalid_attrs)
    end

    test "update_slaughter_order_bundler/2 with valid data updates the slaughter_order_bundler" do
      slaughter_order_bundler = slaughter_order_bundler_fixture()
      assert {:ok, slaughter_order_bundler} = SlaughterOrderBundlers.update_slaughter_order_bundler(slaughter_order_bundler, @update_attrs)
      assert %SlaughterOrderBundler{} = slaughter_order_bundler
    end

    test "update_slaughter_order_bundler/2 with invalid data returns error changeset" do
      slaughter_order_bundler = slaughter_order_bundler_fixture()
      assert {:error, %Ecto.Changeset{}} = SlaughterOrderBundlers.update_slaughter_order_bundler(slaughter_order_bundler, @invalid_attrs)
      assert slaughter_order_bundler == SlaughterOrderBundlers.get_slaughter_order_bundler!(slaughter_order_bundler.id)
    end

    test "delete_slaughter_order_bundler/1 deletes the slaughter_order_bundler" do
      slaughter_order_bundler = slaughter_order_bundler_fixture()
      assert {:ok, %SlaughterOrderBundler{}} = SlaughterOrderBundlers.delete_slaughter_order_bundler(slaughter_order_bundler)
      assert_raise Ecto.NoResultsError, fn -> SlaughterOrderBundlers.get_slaughter_order_bundler!(slaughter_order_bundler.id) end
    end

    test "change_slaughter_order_bundler/1 returns a slaughter_order_bundler changeset" do
      slaughter_order_bundler = slaughter_order_bundler_fixture()
      assert %Ecto.Changeset{} = SlaughterOrderBundlers.change_slaughter_order_bundler(slaughter_order_bundler)
    end
  end
end
