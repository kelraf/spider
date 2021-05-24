defmodule Spider.LivestockOrderProcessingStagesTest do
  use Spider.DataCase

  alias Spider.LivestockOrderProcessingStages

  describe "livestock_order_processing_stages" do
    alias Spider.LivestockOrderProcessingStages.LivestockOrderProcessingStage

    @valid_attrs %{stage_name: "some stage_name", status: 42}
    @update_attrs %{stage_name: "some updated stage_name", status: 43}
    @invalid_attrs %{stage_name: nil, status: nil}

    def livestock_order_processing_stage_fixture(attrs \\ %{}) do
      {:ok, livestock_order_processing_stage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LivestockOrderProcessingStages.create_livestock_order_processing_stage()

      livestock_order_processing_stage
    end

    test "list_livestock_order_processing_stages/0 returns all livestock_order_processing_stages" do
      livestock_order_processing_stage = livestock_order_processing_stage_fixture()
      assert LivestockOrderProcessingStages.list_livestock_order_processing_stages() == [livestock_order_processing_stage]
    end

    test "get_livestock_order_processing_stage!/1 returns the livestock_order_processing_stage with given id" do
      livestock_order_processing_stage = livestock_order_processing_stage_fixture()
      assert LivestockOrderProcessingStages.get_livestock_order_processing_stage!(livestock_order_processing_stage.id) == livestock_order_processing_stage
    end

    test "create_livestock_order_processing_stage/1 with valid data creates a livestock_order_processing_stage" do
      assert {:ok, %LivestockOrderProcessingStage{} = livestock_order_processing_stage} = LivestockOrderProcessingStages.create_livestock_order_processing_stage(@valid_attrs)
      assert livestock_order_processing_stage.stage_name == "some stage_name"
      assert livestock_order_processing_stage.status == 42
    end

    test "create_livestock_order_processing_stage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LivestockOrderProcessingStages.create_livestock_order_processing_stage(@invalid_attrs)
    end

    test "update_livestock_order_processing_stage/2 with valid data updates the livestock_order_processing_stage" do
      livestock_order_processing_stage = livestock_order_processing_stage_fixture()
      assert {:ok, livestock_order_processing_stage} = LivestockOrderProcessingStages.update_livestock_order_processing_stage(livestock_order_processing_stage, @update_attrs)
      assert %LivestockOrderProcessingStage{} = livestock_order_processing_stage
      assert livestock_order_processing_stage.stage_name == "some updated stage_name"
      assert livestock_order_processing_stage.status == 43
    end

    test "update_livestock_order_processing_stage/2 with invalid data returns error changeset" do
      livestock_order_processing_stage = livestock_order_processing_stage_fixture()
      assert {:error, %Ecto.Changeset{}} = LivestockOrderProcessingStages.update_livestock_order_processing_stage(livestock_order_processing_stage, @invalid_attrs)
      assert livestock_order_processing_stage == LivestockOrderProcessingStages.get_livestock_order_processing_stage!(livestock_order_processing_stage.id)
    end

    test "delete_livestock_order_processing_stage/1 deletes the livestock_order_processing_stage" do
      livestock_order_processing_stage = livestock_order_processing_stage_fixture()
      assert {:ok, %LivestockOrderProcessingStage{}} = LivestockOrderProcessingStages.delete_livestock_order_processing_stage(livestock_order_processing_stage)
      assert_raise Ecto.NoResultsError, fn -> LivestockOrderProcessingStages.get_livestock_order_processing_stage!(livestock_order_processing_stage.id) end
    end

    test "change_livestock_order_processing_stage/1 returns a livestock_order_processing_stage changeset" do
      livestock_order_processing_stage = livestock_order_processing_stage_fixture()
      assert %Ecto.Changeset{} = LivestockOrderProcessingStages.change_livestock_order_processing_stage(livestock_order_processing_stage)
    end
  end
end
