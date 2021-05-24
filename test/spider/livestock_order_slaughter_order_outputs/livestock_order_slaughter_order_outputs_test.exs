defmodule Spider.LivestockOrderSlaughterOrderOutputsTest do
  use Spider.DataCase

  alias Spider.LivestockOrderSlaughterOrderOutputs

  describe "livestock_order_slaughter_order_outputs" do
    alias Spider.LivestockOrderSlaughterOrderOutputs.LivestockOrderSlaughterOrderOutput

    @valid_attrs %{output_name: "some output_name", quantity: 42, status: 42, units: "some units"}
    @update_attrs %{output_name: "some updated output_name", quantity: 43, status: 43, units: "some updated units"}
    @invalid_attrs %{output_name: nil, quantity: nil, status: nil, units: nil}

    def livestock_order_slaughter_order_output_fixture(attrs \\ %{}) do
      {:ok, livestock_order_slaughter_order_output} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LivestockOrderSlaughterOrderOutputs.create_livestock_order_slaughter_order_output()

      livestock_order_slaughter_order_output
    end

    test "list_livestock_order_slaughter_order_outputs/0 returns all livestock_order_slaughter_order_outputs" do
      livestock_order_slaughter_order_output = livestock_order_slaughter_order_output_fixture()
      assert LivestockOrderSlaughterOrderOutputs.list_livestock_order_slaughter_order_outputs() == [livestock_order_slaughter_order_output]
    end

    test "get_livestock_order_slaughter_order_output!/1 returns the livestock_order_slaughter_order_output with given id" do
      livestock_order_slaughter_order_output = livestock_order_slaughter_order_output_fixture()
      assert LivestockOrderSlaughterOrderOutputs.get_livestock_order_slaughter_order_output!(livestock_order_slaughter_order_output.id) == livestock_order_slaughter_order_output
    end

    test "create_livestock_order_slaughter_order_output/1 with valid data creates a livestock_order_slaughter_order_output" do
      assert {:ok, %LivestockOrderSlaughterOrderOutput{} = livestock_order_slaughter_order_output} = LivestockOrderSlaughterOrderOutputs.create_livestock_order_slaughter_order_output(@valid_attrs)
      assert livestock_order_slaughter_order_output.output_name == "some output_name"
      assert livestock_order_slaughter_order_output.quantity == 42
      assert livestock_order_slaughter_order_output.status == 42
      assert livestock_order_slaughter_order_output.units == "some units"
    end

    test "create_livestock_order_slaughter_order_output/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LivestockOrderSlaughterOrderOutputs.create_livestock_order_slaughter_order_output(@invalid_attrs)
    end

    test "update_livestock_order_slaughter_order_output/2 with valid data updates the livestock_order_slaughter_order_output" do
      livestock_order_slaughter_order_output = livestock_order_slaughter_order_output_fixture()
      assert {:ok, livestock_order_slaughter_order_output} = LivestockOrderSlaughterOrderOutputs.update_livestock_order_slaughter_order_output(livestock_order_slaughter_order_output, @update_attrs)
      assert %LivestockOrderSlaughterOrderOutput{} = livestock_order_slaughter_order_output
      assert livestock_order_slaughter_order_output.output_name == "some updated output_name"
      assert livestock_order_slaughter_order_output.quantity == 43
      assert livestock_order_slaughter_order_output.status == 43
      assert livestock_order_slaughter_order_output.units == "some updated units"
    end

    test "update_livestock_order_slaughter_order_output/2 with invalid data returns error changeset" do
      livestock_order_slaughter_order_output = livestock_order_slaughter_order_output_fixture()
      assert {:error, %Ecto.Changeset{}} = LivestockOrderSlaughterOrderOutputs.update_livestock_order_slaughter_order_output(livestock_order_slaughter_order_output, @invalid_attrs)
      assert livestock_order_slaughter_order_output == LivestockOrderSlaughterOrderOutputs.get_livestock_order_slaughter_order_output!(livestock_order_slaughter_order_output.id)
    end

    test "delete_livestock_order_slaughter_order_output/1 deletes the livestock_order_slaughter_order_output" do
      livestock_order_slaughter_order_output = livestock_order_slaughter_order_output_fixture()
      assert {:ok, %LivestockOrderSlaughterOrderOutput{}} = LivestockOrderSlaughterOrderOutputs.delete_livestock_order_slaughter_order_output(livestock_order_slaughter_order_output)
      assert_raise Ecto.NoResultsError, fn -> LivestockOrderSlaughterOrderOutputs.get_livestock_order_slaughter_order_output!(livestock_order_slaughter_order_output.id) end
    end

    test "change_livestock_order_slaughter_order_output/1 returns a livestock_order_slaughter_order_output changeset" do
      livestock_order_slaughter_order_output = livestock_order_slaughter_order_output_fixture()
      assert %Ecto.Changeset{} = LivestockOrderSlaughterOrderOutputs.change_livestock_order_slaughter_order_output(livestock_order_slaughter_order_output)
    end
  end
end
