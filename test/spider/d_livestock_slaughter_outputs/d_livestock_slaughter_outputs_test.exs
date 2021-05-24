defmodule Spider.DLivestockSlaughterOutputsTest do
  use Spider.DataCase

  alias Spider.DLivestockSlaughterOutputs

  describe "d_livestock_slaughter_outputs" do
    alias Spider.DLivestockSlaughterOutputs.DLivestockSlaughterOutput

    @valid_attrs %{checked: true, output_name: "some output_name", units: 42}
    @update_attrs %{checked: false, output_name: "some updated output_name", units: 43}
    @invalid_attrs %{checked: nil, output_name: nil, units: nil}

    def d_livestock_slaughter_output_fixture(attrs \\ %{}) do
      {:ok, d_livestock_slaughter_output} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DLivestockSlaughterOutputs.create_d_livestock_slaughter_output()

      d_livestock_slaughter_output
    end

    test "list_d_livestock_slaughter_outputs/0 returns all d_livestock_slaughter_outputs" do
      d_livestock_slaughter_output = d_livestock_slaughter_output_fixture()
      assert DLivestockSlaughterOutputs.list_d_livestock_slaughter_outputs() == [d_livestock_slaughter_output]
    end

    test "get_d_livestock_slaughter_output!/1 returns the d_livestock_slaughter_output with given id" do
      d_livestock_slaughter_output = d_livestock_slaughter_output_fixture()
      assert DLivestockSlaughterOutputs.get_d_livestock_slaughter_output!(d_livestock_slaughter_output.id) == d_livestock_slaughter_output
    end

    test "create_d_livestock_slaughter_output/1 with valid data creates a d_livestock_slaughter_output" do
      assert {:ok, %DLivestockSlaughterOutput{} = d_livestock_slaughter_output} = DLivestockSlaughterOutputs.create_d_livestock_slaughter_output(@valid_attrs)
      assert d_livestock_slaughter_output.checked == true
      assert d_livestock_slaughter_output.output_name == "some output_name"
      assert d_livestock_slaughter_output.units == 42
    end

    test "create_d_livestock_slaughter_output/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DLivestockSlaughterOutputs.create_d_livestock_slaughter_output(@invalid_attrs)
    end

    test "update_d_livestock_slaughter_output/2 with valid data updates the d_livestock_slaughter_output" do
      d_livestock_slaughter_output = d_livestock_slaughter_output_fixture()
      assert {:ok, d_livestock_slaughter_output} = DLivestockSlaughterOutputs.update_d_livestock_slaughter_output(d_livestock_slaughter_output, @update_attrs)
      assert %DLivestockSlaughterOutput{} = d_livestock_slaughter_output
      assert d_livestock_slaughter_output.checked == false
      assert d_livestock_slaughter_output.output_name == "some updated output_name"
      assert d_livestock_slaughter_output.units == 43
    end

    test "update_d_livestock_slaughter_output/2 with invalid data returns error changeset" do
      d_livestock_slaughter_output = d_livestock_slaughter_output_fixture()
      assert {:error, %Ecto.Changeset{}} = DLivestockSlaughterOutputs.update_d_livestock_slaughter_output(d_livestock_slaughter_output, @invalid_attrs)
      assert d_livestock_slaughter_output == DLivestockSlaughterOutputs.get_d_livestock_slaughter_output!(d_livestock_slaughter_output.id)
    end

    test "delete_d_livestock_slaughter_output/1 deletes the d_livestock_slaughter_output" do
      d_livestock_slaughter_output = d_livestock_slaughter_output_fixture()
      assert {:ok, %DLivestockSlaughterOutput{}} = DLivestockSlaughterOutputs.delete_d_livestock_slaughter_output(d_livestock_slaughter_output)
      assert_raise Ecto.NoResultsError, fn -> DLivestockSlaughterOutputs.get_d_livestock_slaughter_output!(d_livestock_slaughter_output.id) end
    end

    test "change_d_livestock_slaughter_output/1 returns a d_livestock_slaughter_output changeset" do
      d_livestock_slaughter_output = d_livestock_slaughter_output_fixture()
      assert %Ecto.Changeset{} = DLivestockSlaughterOutputs.change_d_livestock_slaughter_output(d_livestock_slaughter_output)
    end
  end
end
