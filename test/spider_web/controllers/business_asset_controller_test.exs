defmodule SpiderWeb.BusinessAssetControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.BusinessAssets
  alias Spider.BusinessAssets.BusinessAsset

  @create_attrs %{asset_name: "some asset_name"}
  @update_attrs %{asset_name: "some updated asset_name"}
  @invalid_attrs %{asset_name: nil}

  def fixture(:business_asset) do
    {:ok, business_asset} = BusinessAssets.create_business_asset(@create_attrs)
    business_asset
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all business_assets", %{conn: conn} do
      conn = get conn, business_asset_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create business_asset" do
    test "renders business_asset when data is valid", %{conn: conn} do
      conn = post conn, business_asset_path(conn, :create), business_asset: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, business_asset_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "asset_name" => "some asset_name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, business_asset_path(conn, :create), business_asset: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update business_asset" do
    setup [:create_business_asset]

    test "renders business_asset when data is valid", %{conn: conn, business_asset: %BusinessAsset{id: id} = business_asset} do
      conn = put conn, business_asset_path(conn, :update, business_asset), business_asset: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, business_asset_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "asset_name" => "some updated asset_name"}
    end

    test "renders errors when data is invalid", %{conn: conn, business_asset: business_asset} do
      conn = put conn, business_asset_path(conn, :update, business_asset), business_asset: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete business_asset" do
    setup [:create_business_asset]

    test "deletes chosen business_asset", %{conn: conn, business_asset: business_asset} do
      conn = delete conn, business_asset_path(conn, :delete, business_asset)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, business_asset_path(conn, :show, business_asset)
      end
    end
  end

  defp create_business_asset(_) do
    business_asset = fixture(:business_asset)
    {:ok, business_asset: business_asset}
  end
end
