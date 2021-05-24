defmodule Spider.TLivestocksTest do
  use Spider.DataCase

  alias Spider.TLivestocks

  describe "tlivestocks" do
    alias Spider.TLivestocks.TLivestock

    @valid_attrs %{quantity: 42}
    @update_attrs %{quantity: 43}
    @invalid_attrs %{quantity: nil}

    def t_livestock_fixture(attrs \\ %{}) do
      {:ok, t_livestock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TLivestocks.create_t_livestock()

      t_livestock
    end

    test "list_tlivestocks/0 returns all tlivestocks" do
      t_livestock = t_livestock_fixture()
      assert TLivestocks.list_tlivestocks() == [t_livestock]
    end

    test "get_t_livestock!/1 returns the t_livestock with given id" do
      t_livestock = t_livestock_fixture()
      assert TLivestocks.get_t_livestock!(t_livestock.id) == t_livestock
    end

    test "create_t_livestock/1 with valid data creates a t_livestock" do
      assert {:ok, %TLivestock{} = t_livestock} = TLivestocks.create_t_livestock(@valid_attrs)
      assert t_livestock.quantity == 42
    end

    test "create_t_livestock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TLivestocks.create_t_livestock(@invalid_attrs)
    end

    test "update_t_livestock/2 with valid data updates the t_livestock" do
      t_livestock = t_livestock_fixture()
      assert {:ok, t_livestock} = TLivestocks.update_t_livestock(t_livestock, @update_attrs)
      assert %TLivestock{} = t_livestock
      assert t_livestock.quantity == 43
    end

    test "update_t_livestock/2 with invalid data returns error changeset" do
      t_livestock = t_livestock_fixture()
      assert {:error, %Ecto.Changeset{}} = TLivestocks.update_t_livestock(t_livestock, @invalid_attrs)
      assert t_livestock == TLivestocks.get_t_livestock!(t_livestock.id)
    end

    test "delete_t_livestock/1 deletes the t_livestock" do
      t_livestock = t_livestock_fixture()
      assert {:ok, %TLivestock{}} = TLivestocks.delete_t_livestock(t_livestock)
      assert_raise Ecto.NoResultsError, fn -> TLivestocks.get_t_livestock!(t_livestock.id) end
    end

    test "change_t_livestock/1 returns a t_livestock changeset" do
      t_livestock = t_livestock_fixture()
      assert %Ecto.Changeset{} = TLivestocks.change_t_livestock(t_livestock)
    end
  end
end
