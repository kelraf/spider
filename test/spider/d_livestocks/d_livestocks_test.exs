defmodule Spider.DLivestocksTest do
  use Spider.DataCase

  alias Spider.DLivestocks

  describe "dlivestock" do
    alias Spider.DLivestocks.DLivestock

    @valid_attrs %{breed: "some breed", category: "some category", reference: "some reference", type: "some type"}
    @update_attrs %{breed: "some updated breed", category: "some updated category", reference: "some updated reference", type: "some updated type"}
    @invalid_attrs %{breed: nil, category: nil, reference: nil, type: nil}

    def d_livestock_fixture(attrs \\ %{}) do
      {:ok, d_livestock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DLivestocks.create_d_livestock()

      d_livestock
    end

    test "list_dlivestock/0 returns all dlivestock" do
      d_livestock = d_livestock_fixture()
      assert DLivestocks.list_dlivestock() == [d_livestock]
    end

    test "get_d_livestock!/1 returns the d_livestock with given id" do
      d_livestock = d_livestock_fixture()
      assert DLivestocks.get_d_livestock!(d_livestock.id) == d_livestock
    end

    test "create_d_livestock/1 with valid data creates a d_livestock" do
      assert {:ok, %DLivestock{} = d_livestock} = DLivestocks.create_d_livestock(@valid_attrs)
      assert d_livestock.breed == "some breed"
      assert d_livestock.category == "some category"
      assert d_livestock.reference == "some reference"
      assert d_livestock.type == "some type"
    end

    test "create_d_livestock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DLivestocks.create_d_livestock(@invalid_attrs)
    end

    test "update_d_livestock/2 with valid data updates the d_livestock" do
      d_livestock = d_livestock_fixture()
      assert {:ok, d_livestock} = DLivestocks.update_d_livestock(d_livestock, @update_attrs)
      assert %DLivestock{} = d_livestock
      assert d_livestock.breed == "some updated breed"
      assert d_livestock.category == "some updated category"
      assert d_livestock.reference == "some updated reference"
      assert d_livestock.type == "some updated type"
    end

    test "update_d_livestock/2 with invalid data returns error changeset" do
      d_livestock = d_livestock_fixture()
      assert {:error, %Ecto.Changeset{}} = DLivestocks.update_d_livestock(d_livestock, @invalid_attrs)
      assert d_livestock == DLivestocks.get_d_livestock!(d_livestock.id)
    end

    test "delete_d_livestock/1 deletes the d_livestock" do
      d_livestock = d_livestock_fixture()
      assert {:ok, %DLivestock{}} = DLivestocks.delete_d_livestock(d_livestock)
      assert_raise Ecto.NoResultsError, fn -> DLivestocks.get_d_livestock!(d_livestock.id) end
    end

    test "change_d_livestock/1 returns a d_livestock changeset" do
      d_livestock = d_livestock_fixture()
      assert %Ecto.Changeset{} = DLivestocks.change_d_livestock(d_livestock)
    end
  end
end
