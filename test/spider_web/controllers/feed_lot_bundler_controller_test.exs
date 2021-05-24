defmodule SpiderWeb.FeedLotBundlerControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.FeedLotBundlers
  alias Spider.FeedLotBundlers.FeedLotBundler

  @create_attrs %{business_id: "some business_id", "businesses,": "some businesses,", delete_all: "some delete_all", on_delete: "some on_delete", references: "some references"}
  @update_attrs %{business_id: "some updated business_id", "businesses,": "some updated businesses,", delete_all: "some updated delete_all", on_delete: "some updated on_delete", references: "some updated references"}
  @invalid_attrs %{business_id: nil, "businesses,": nil, delete_all: nil, on_delete: nil, references: nil}

  def fixture(:feed_lot_bundler) do
    {:ok, feed_lot_bundler} = FeedLotBundlers.create_feed_lot_bundler(@create_attrs)
    feed_lot_bundler
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all feed_lot_bundlers", %{conn: conn} do
      conn = get conn, feed_lot_bundler_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create feed_lot_bundler" do
    test "renders feed_lot_bundler when data is valid", %{conn: conn} do
      conn = post conn, feed_lot_bundler_path(conn, :create), feed_lot_bundler: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, feed_lot_bundler_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "business_id" => "some business_id",
        "businesses," => "some businesses,",
        "delete_all" => "some delete_all",
        "on_delete" => "some on_delete",
        "references" => "some references"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, feed_lot_bundler_path(conn, :create), feed_lot_bundler: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update feed_lot_bundler" do
    setup [:create_feed_lot_bundler]

    test "renders feed_lot_bundler when data is valid", %{conn: conn, feed_lot_bundler: %FeedLotBundler{id: id} = feed_lot_bundler} do
      conn = put conn, feed_lot_bundler_path(conn, :update, feed_lot_bundler), feed_lot_bundler: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, feed_lot_bundler_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "business_id" => "some updated business_id",
        "businesses," => "some updated businesses,",
        "delete_all" => "some updated delete_all",
        "on_delete" => "some updated on_delete",
        "references" => "some updated references"}
    end

    test "renders errors when data is invalid", %{conn: conn, feed_lot_bundler: feed_lot_bundler} do
      conn = put conn, feed_lot_bundler_path(conn, :update, feed_lot_bundler), feed_lot_bundler: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete feed_lot_bundler" do
    setup [:create_feed_lot_bundler]

    test "deletes chosen feed_lot_bundler", %{conn: conn, feed_lot_bundler: feed_lot_bundler} do
      conn = delete conn, feed_lot_bundler_path(conn, :delete, feed_lot_bundler)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, feed_lot_bundler_path(conn, :show, feed_lot_bundler)
      end
    end
  end

  defp create_feed_lot_bundler(_) do
    feed_lot_bundler = fixture(:feed_lot_bundler)
    {:ok, feed_lot_bundler: feed_lot_bundler}
  end
end
