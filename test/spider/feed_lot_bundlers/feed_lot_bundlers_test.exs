defmodule Spider.FeedLotBundlersTest do
  use Spider.DataCase

  alias Spider.FeedLotBundlers

  describe "feed_lot_bundlers" do
    alias Spider.FeedLotBundlers.FeedLotBundler

    @valid_attrs %{business_id: "some business_id", "businesses,": "some businesses,", delete_all: "some delete_all", on_delete: "some on_delete", references: "some references"}
    @update_attrs %{business_id: "some updated business_id", "businesses,": "some updated businesses,", delete_all: "some updated delete_all", on_delete: "some updated on_delete", references: "some updated references"}
    @invalid_attrs %{business_id: nil, "businesses,": nil, delete_all: nil, on_delete: nil, references: nil}

    def feed_lot_bundler_fixture(attrs \\ %{}) do
      {:ok, feed_lot_bundler} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FeedLotBundlers.create_feed_lot_bundler()

      feed_lot_bundler
    end

    test "list_feed_lot_bundlers/0 returns all feed_lot_bundlers" do
      feed_lot_bundler = feed_lot_bundler_fixture()
      assert FeedLotBundlers.list_feed_lot_bundlers() == [feed_lot_bundler]
    end

    test "get_feed_lot_bundler!/1 returns the feed_lot_bundler with given id" do
      feed_lot_bundler = feed_lot_bundler_fixture()
      assert FeedLotBundlers.get_feed_lot_bundler!(feed_lot_bundler.id) == feed_lot_bundler
    end

    test "create_feed_lot_bundler/1 with valid data creates a feed_lot_bundler" do
      assert {:ok, %FeedLotBundler{} = feed_lot_bundler} = FeedLotBundlers.create_feed_lot_bundler(@valid_attrs)
      assert feed_lot_bundler.business_id == "some business_id"
      assert feed_lot_bundler.businesses, == "some businesses,"
      assert feed_lot_bundler.delete_all == "some delete_all"
      assert feed_lot_bundler.on_delete == "some on_delete"
      assert feed_lot_bundler.references == "some references"
    end

    test "create_feed_lot_bundler/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FeedLotBundlers.create_feed_lot_bundler(@invalid_attrs)
    end

    test "update_feed_lot_bundler/2 with valid data updates the feed_lot_bundler" do
      feed_lot_bundler = feed_lot_bundler_fixture()
      assert {:ok, feed_lot_bundler} = FeedLotBundlers.update_feed_lot_bundler(feed_lot_bundler, @update_attrs)
      assert %FeedLotBundler{} = feed_lot_bundler
      assert feed_lot_bundler.business_id == "some updated business_id"
      assert feed_lot_bundler.businesses, == "some updated businesses,"
      assert feed_lot_bundler.delete_all == "some updated delete_all"
      assert feed_lot_bundler.on_delete == "some updated on_delete"
      assert feed_lot_bundler.references == "some updated references"
    end

    test "update_feed_lot_bundler/2 with invalid data returns error changeset" do
      feed_lot_bundler = feed_lot_bundler_fixture()
      assert {:error, %Ecto.Changeset{}} = FeedLotBundlers.update_feed_lot_bundler(feed_lot_bundler, @invalid_attrs)
      assert feed_lot_bundler == FeedLotBundlers.get_feed_lot_bundler!(feed_lot_bundler.id)
    end

    test "delete_feed_lot_bundler/1 deletes the feed_lot_bundler" do
      feed_lot_bundler = feed_lot_bundler_fixture()
      assert {:ok, %FeedLotBundler{}} = FeedLotBundlers.delete_feed_lot_bundler(feed_lot_bundler)
      assert_raise Ecto.NoResultsError, fn -> FeedLotBundlers.get_feed_lot_bundler!(feed_lot_bundler.id) end
    end

    test "change_feed_lot_bundler/1 returns a feed_lot_bundler changeset" do
      feed_lot_bundler = feed_lot_bundler_fixture()
      assert %Ecto.Changeset{} = FeedLotBundlers.change_feed_lot_bundler(feed_lot_bundler)
    end
  end
end
