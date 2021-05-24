defmodule Spider.ExportZoneBundlersTest do
  use Spider.DataCase

  alias Spider.ExportZoneBundlers

  describe "export_zone_bundler" do
    alias Spider.ExportZoneBundlers.ExportZoneBundler

    @valid_attrs %{capacity: 42, size: "some size"}
    @update_attrs %{capacity: 43, size: "some updated size"}
    @invalid_attrs %{capacity: nil, size: nil}

    def export_zone_bundler_fixture(attrs \\ %{}) do
      {:ok, export_zone_bundler} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ExportZoneBundlers.create_export_zone_bundler()

      export_zone_bundler
    end

    test "list_export_zone_bundler/0 returns all export_zone_bundler" do
      export_zone_bundler = export_zone_bundler_fixture()
      assert ExportZoneBundlers.list_export_zone_bundler() == [export_zone_bundler]
    end

    test "get_export_zone_bundler!/1 returns the export_zone_bundler with given id" do
      export_zone_bundler = export_zone_bundler_fixture()
      assert ExportZoneBundlers.get_export_zone_bundler!(export_zone_bundler.id) == export_zone_bundler
    end

    test "create_export_zone_bundler/1 with valid data creates a export_zone_bundler" do
      assert {:ok, %ExportZoneBundler{} = export_zone_bundler} = ExportZoneBundlers.create_export_zone_bundler(@valid_attrs)
      assert export_zone_bundler.capacity == 42
      assert export_zone_bundler.size == "some size"
    end

    test "create_export_zone_bundler/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ExportZoneBundlers.create_export_zone_bundler(@invalid_attrs)
    end

    test "update_export_zone_bundler/2 with valid data updates the export_zone_bundler" do
      export_zone_bundler = export_zone_bundler_fixture()
      assert {:ok, export_zone_bundler} = ExportZoneBundlers.update_export_zone_bundler(export_zone_bundler, @update_attrs)
      assert %ExportZoneBundler{} = export_zone_bundler
      assert export_zone_bundler.capacity == 43
      assert export_zone_bundler.size == "some updated size"
    end

    test "update_export_zone_bundler/2 with invalid data returns error changeset" do
      export_zone_bundler = export_zone_bundler_fixture()
      assert {:error, %Ecto.Changeset{}} = ExportZoneBundlers.update_export_zone_bundler(export_zone_bundler, @invalid_attrs)
      assert export_zone_bundler == ExportZoneBundlers.get_export_zone_bundler!(export_zone_bundler.id)
    end

    test "delete_export_zone_bundler/1 deletes the export_zone_bundler" do
      export_zone_bundler = export_zone_bundler_fixture()
      assert {:ok, %ExportZoneBundler{}} = ExportZoneBundlers.delete_export_zone_bundler(export_zone_bundler)
      assert_raise Ecto.NoResultsError, fn -> ExportZoneBundlers.get_export_zone_bundler!(export_zone_bundler.id) end
    end

    test "change_export_zone_bundler/1 returns a export_zone_bundler changeset" do
      export_zone_bundler = export_zone_bundler_fixture()
      assert %Ecto.Changeset{} = ExportZoneBundlers.change_export_zone_bundler(export_zone_bundler)
    end
  end
end
