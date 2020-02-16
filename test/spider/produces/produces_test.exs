defmodule Spider.ProducesTest do
  use Spider.DataCase

  alias Spider.Produces

  describe "produces" do
    alias Spider.Produces.Produce

    @valid_attrs %{amount: 42, category: "some category", type: "some type", units: "some units"}
    @update_attrs %{amount: 43, category: "some updated category", type: "some updated type", units: "some updated units"}
    @invalid_attrs %{amount: nil, category: nil, type: nil, units: nil}

    def produce_fixture(attrs \\ %{}) do
      {:ok, produce} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Produces.create_produce()

      produce
    end

    test "list_produces/0 returns all produces" do
      produce = produce_fixture()
      assert Produces.list_produces() == [produce]
    end

    test "get_produce!/1 returns the produce with given id" do
      produce = produce_fixture()
      assert Produces.get_produce!(produce.id) == produce
    end

    test "create_produce/1 with valid data creates a produce" do
      assert {:ok, %Produce{} = produce} = Produces.create_produce(@valid_attrs)
      assert produce.amount == 42
      assert produce.category == "some category"
      assert produce.type == "some type"
      assert produce.units == "some units"
    end

    test "create_produce/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Produces.create_produce(@invalid_attrs)
    end

    test "update_produce/2 with valid data updates the produce" do
      produce = produce_fixture()
      assert {:ok, produce} = Produces.update_produce(produce, @update_attrs)
      assert %Produce{} = produce
      assert produce.amount == 43
      assert produce.category == "some updated category"
      assert produce.type == "some updated type"
      assert produce.units == "some updated units"
    end

    test "update_produce/2 with invalid data returns error changeset" do
      produce = produce_fixture()
      assert {:error, %Ecto.Changeset{}} = Produces.update_produce(produce, @invalid_attrs)
      assert produce == Produces.get_produce!(produce.id)
    end

    test "delete_produce/1 deletes the produce" do
      produce = produce_fixture()
      assert {:ok, %Produce{}} = Produces.delete_produce(produce)
      assert_raise Ecto.NoResultsError, fn -> Produces.get_produce!(produce.id) end
    end

    test "change_produce/1 returns a produce changeset" do
      produce = produce_fixture()
      assert %Ecto.Changeset{} = Produces.change_produce(produce)
    end
  end
end
