defmodule Spider.BusinessAssetsTest do
  use Spider.DataCase

  alias Spider.BusinessAssets

  describe "business_assets" do
    alias Spider.BusinessAssets.BusinessAsset

    @valid_attrs %{asset_name: "some asset_name"}
    @update_attrs %{asset_name: "some updated asset_name"}
    @invalid_attrs %{asset_name: nil}

    def business_asset_fixture(attrs \\ %{}) do
      {:ok, business_asset} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BusinessAssets.create_business_asset()

      business_asset
    end

    test "list_business_assets/0 returns all business_assets" do
      business_asset = business_asset_fixture()
      assert BusinessAssets.list_business_assets() == [business_asset]
    end

    test "get_business_asset!/1 returns the business_asset with given id" do
      business_asset = business_asset_fixture()
      assert BusinessAssets.get_business_asset!(business_asset.id) == business_asset
    end

    test "create_business_asset/1 with valid data creates a business_asset" do
      assert {:ok, %BusinessAsset{} = business_asset} = BusinessAssets.create_business_asset(@valid_attrs)
      assert business_asset.asset_name == "some asset_name"
    end

    test "create_business_asset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BusinessAssets.create_business_asset(@invalid_attrs)
    end

    test "update_business_asset/2 with valid data updates the business_asset" do
      business_asset = business_asset_fixture()
      assert {:ok, business_asset} = BusinessAssets.update_business_asset(business_asset, @update_attrs)
      assert %BusinessAsset{} = business_asset
      assert business_asset.asset_name == "some updated asset_name"
    end

    test "update_business_asset/2 with invalid data returns error changeset" do
      business_asset = business_asset_fixture()
      assert {:error, %Ecto.Changeset{}} = BusinessAssets.update_business_asset(business_asset, @invalid_attrs)
      assert business_asset == BusinessAssets.get_business_asset!(business_asset.id)
    end

    test "delete_business_asset/1 deletes the business_asset" do
      business_asset = business_asset_fixture()
      assert {:ok, %BusinessAsset{}} = BusinessAssets.delete_business_asset(business_asset)
      assert_raise Ecto.NoResultsError, fn -> BusinessAssets.get_business_asset!(business_asset.id) end
    end

    test "change_business_asset/1 returns a business_asset changeset" do
      business_asset = business_asset_fixture()
      assert %Ecto.Changeset{} = BusinessAssets.change_business_asset(business_asset)
    end
  end
end
