defmodule Spider.ProduceOrderStagesTest do
  use Spider.DataCase

  alias Spider.ProduceOrderStages

  describe "produce_order_stages" do
    alias Spider.ProduceOrderStages.ProduceOrderStage

    @valid_attrs %{stage_name: "some stage_name", stage_number: 42, status: 42}
    @update_attrs %{stage_name: "some updated stage_name", stage_number: 43, status: 43}
    @invalid_attrs %{stage_name: nil, stage_number: nil, status: nil}

    def produce_order_stage_fixture(attrs \\ %{}) do
      {:ok, produce_order_stage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProduceOrderStages.create_produce_order_stage()

      produce_order_stage
    end

    test "list_produce_order_stages/0 returns all produce_order_stages" do
      produce_order_stage = produce_order_stage_fixture()
      assert ProduceOrderStages.list_produce_order_stages() == [produce_order_stage]
    end

    test "get_produce_order_stage!/1 returns the produce_order_stage with given id" do
      produce_order_stage = produce_order_stage_fixture()
      assert ProduceOrderStages.get_produce_order_stage!(produce_order_stage.id) == produce_order_stage
    end

    test "create_produce_order_stage/1 with valid data creates a produce_order_stage" do
      assert {:ok, %ProduceOrderStage{} = produce_order_stage} = ProduceOrderStages.create_produce_order_stage(@valid_attrs)
      assert produce_order_stage.stage_name == "some stage_name"
      assert produce_order_stage.stage_number == 42
      assert produce_order_stage.status == 42
    end

    test "create_produce_order_stage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProduceOrderStages.create_produce_order_stage(@invalid_attrs)
    end

    test "update_produce_order_stage/2 with valid data updates the produce_order_stage" do
      produce_order_stage = produce_order_stage_fixture()
      assert {:ok, produce_order_stage} = ProduceOrderStages.update_produce_order_stage(produce_order_stage, @update_attrs)
      assert %ProduceOrderStage{} = produce_order_stage
      assert produce_order_stage.stage_name == "some updated stage_name"
      assert produce_order_stage.stage_number == 43
      assert produce_order_stage.status == 43
    end

    test "update_produce_order_stage/2 with invalid data returns error changeset" do
      produce_order_stage = produce_order_stage_fixture()
      assert {:error, %Ecto.Changeset{}} = ProduceOrderStages.update_produce_order_stage(produce_order_stage, @invalid_attrs)
      assert produce_order_stage == ProduceOrderStages.get_produce_order_stage!(produce_order_stage.id)
    end

    test "delete_produce_order_stage/1 deletes the produce_order_stage" do
      produce_order_stage = produce_order_stage_fixture()
      assert {:ok, %ProduceOrderStage{}} = ProduceOrderStages.delete_produce_order_stage(produce_order_stage)
      assert_raise Ecto.NoResultsError, fn -> ProduceOrderStages.get_produce_order_stage!(produce_order_stage.id) end
    end

    test "change_produce_order_stage/1 returns a produce_order_stage changeset" do
      produce_order_stage = produce_order_stage_fixture()
      assert %Ecto.Changeset{} = ProduceOrderStages.change_produce_order_stage(produce_order_stage)
    end
  end
end
