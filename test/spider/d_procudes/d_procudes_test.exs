defmodule Spider.DProcudesTest do
  use Spider.DataCase

  alias Spider.DProcudes

  describe "dproduces" do
    alias Spider.DProcudes.DProduce

    @valid_attrs %{category: "some category", reference: "some reference", units: "some units"}
    @update_attrs %{category: "some updated category", reference: "some updated reference", units: "some updated units"}
    @invalid_attrs %{category: nil, reference: nil, units: nil}

    def d_produce_fixture(attrs \\ %{}) do
      {:ok, d_produce} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DProcudes.create_d_produce()

      d_produce
    end

    test "list_dproduces/0 returns all dproduces" do
      d_produce = d_produce_fixture()
      assert DProcudes.list_dproduces() == [d_produce]
    end

    test "get_d_produce!/1 returns the d_produce with given id" do
      d_produce = d_produce_fixture()
      assert DProcudes.get_d_produce!(d_produce.id) == d_produce
    end

    test "create_d_produce/1 with valid data creates a d_produce" do
      assert {:ok, %DProduce{} = d_produce} = DProcudes.create_d_produce(@valid_attrs)
      assert d_produce.category == "some category"
      assert d_produce.reference == "some reference"
      assert d_produce.units == "some units"
    end

    test "create_d_produce/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DProcudes.create_d_produce(@invalid_attrs)
    end

    test "update_d_produce/2 with valid data updates the d_produce" do
      d_produce = d_produce_fixture()
      assert {:ok, d_produce} = DProcudes.update_d_produce(d_produce, @update_attrs)
      assert %DProduce{} = d_produce
      assert d_produce.category == "some updated category"
      assert d_produce.reference == "some updated reference"
      assert d_produce.units == "some updated units"
    end

    test "update_d_produce/2 with invalid data returns error changeset" do
      d_produce = d_produce_fixture()
      assert {:error, %Ecto.Changeset{}} = DProcudes.update_d_produce(d_produce, @invalid_attrs)
      assert d_produce == DProcudes.get_d_produce!(d_produce.id)
    end

    test "delete_d_produce/1 deletes the d_produce" do
      d_produce = d_produce_fixture()
      assert {:ok, %DProduce{}} = DProcudes.delete_d_produce(d_produce)
      assert_raise Ecto.NoResultsError, fn -> DProcudes.get_d_produce!(d_produce.id) end
    end

    test "change_d_produce/1 returns a d_produce changeset" do
      d_produce = d_produce_fixture()
      assert %Ecto.Changeset{} = DProcudes.change_d_produce(d_produce)
    end
  end
end
