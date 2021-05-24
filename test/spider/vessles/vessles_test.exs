defmodule Spider.VesslesTest do
  use Spider.DataCase

  alias Spider.Vessles

  describe "vessles" do
    alias Spider.Vessles.Vessle

    @valid_attrs %{role: "some role", unique_number: "some unique_number"}
    @update_attrs %{role: "some updated role", unique_number: "some updated unique_number"}
    @invalid_attrs %{role: nil, unique_number: nil}

    def vessle_fixture(attrs \\ %{}) do
      {:ok, vessle} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Vessles.create_vessle()

      vessle
    end

    test "list_vessles/0 returns all vessles" do
      vessle = vessle_fixture()
      assert Vessles.list_vessles() == [vessle]
    end

    test "get_vessle!/1 returns the vessle with given id" do
      vessle = vessle_fixture()
      assert Vessles.get_vessle!(vessle.id) == vessle
    end

    test "create_vessle/1 with valid data creates a vessle" do
      assert {:ok, %Vessle{} = vessle} = Vessles.create_vessle(@valid_attrs)
      assert vessle.role == "some role"
      assert vessle.unique_number == "some unique_number"
    end

    test "create_vessle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vessles.create_vessle(@invalid_attrs)
    end

    test "update_vessle/2 with valid data updates the vessle" do
      vessle = vessle_fixture()
      assert {:ok, vessle} = Vessles.update_vessle(vessle, @update_attrs)
      assert %Vessle{} = vessle
      assert vessle.role == "some updated role"
      assert vessle.unique_number == "some updated unique_number"
    end

    test "update_vessle/2 with invalid data returns error changeset" do
      vessle = vessle_fixture()
      assert {:error, %Ecto.Changeset{}} = Vessles.update_vessle(vessle, @invalid_attrs)
      assert vessle == Vessles.get_vessle!(vessle.id)
    end

    test "delete_vessle/1 deletes the vessle" do
      vessle = vessle_fixture()
      assert {:ok, %Vessle{}} = Vessles.delete_vessle(vessle)
      assert_raise Ecto.NoResultsError, fn -> Vessles.get_vessle!(vessle.id) end
    end

    test "change_vessle/1 returns a vessle changeset" do
      vessle = vessle_fixture()
      assert %Ecto.Changeset{} = Vessles.change_vessle(vessle)
    end
  end
end
