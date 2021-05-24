defmodule Spider.LivestocksTest do
  use Spider.DataCase

  alias Spider.Livestocks

  describe "livestocks" do
    alias Spider.Livestocks.Livestock

    @valid_attrs %{category: "some category", number: "some number", type: "some type"}
    @update_attrs %{category: "some updated category", number: "some updated number", type: "some updated type"}
    @invalid_attrs %{category: nil, number: nil, type: nil}

    def livestock_fixture(attrs \\ %{}) do
      {:ok, livestock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Livestocks.create_livestock()

      livestock
    end

    test "list_livestocks/0 returns all livestocks" do
      livestock = livestock_fixture()
      assert Livestocks.list_livestocks() == [livestock]
    end

    test "get_livestock!/1 returns the livestock with given id" do
      livestock = livestock_fixture()
      assert Livestocks.get_livestock!(livestock.id) == livestock
    end

    test "create_livestock/1 with valid data creates a livestock" do
      assert {:ok, %Livestock{} = livestock} = Livestocks.create_livestock(@valid_attrs)
      assert livestock.category == "some category"
      assert livestock.number == "some number"
      assert livestock.type == "some type"
    end

    test "create_livestock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Livestocks.create_livestock(@invalid_attrs)
    end

    test "update_livestock/2 with valid data updates the livestock" do
      livestock = livestock_fixture()
      assert {:ok, livestock} = Livestocks.update_livestock(livestock, @update_attrs)
      assert %Livestock{} = livestock
      assert livestock.category == "some updated category"
      assert livestock.number == "some updated number"
      assert livestock.type == "some updated type"
    end

    test "update_livestock/2 with invalid data returns error changeset" do
      livestock = livestock_fixture()
      assert {:error, %Ecto.Changeset{}} = Livestocks.update_livestock(livestock, @invalid_attrs)
      assert livestock == Livestocks.get_livestock!(livestock.id)
    end

    test "delete_livestock/1 deletes the livestock" do
      livestock = livestock_fixture()
      assert {:ok, %Livestock{}} = Livestocks.delete_livestock(livestock)
      assert_raise Ecto.NoResultsError, fn -> Livestocks.get_livestock!(livestock.id) end
    end

    test "change_livestock/1 returns a livestock changeset" do
      livestock = livestock_fixture()
      assert %Ecto.Changeset{} = Livestocks.change_livestock(livestock)
    end
  end
end
