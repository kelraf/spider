defmodule Spider.LivestockOrderStagesTest do
  use Spider.DataCase

  alias Spider.LivestockOrderStages

  describe "livestock_order_stages" do
    alias Spider.LivestockOrderStages.LivestockOrderStage

    @valid_attrs %{stage_name: "some stage_name"}
    @update_attrs %{stage_name: "some updated stage_name"}
    @invalid_attrs %{stage_name: nil}

    def livestock_order_stage_fixture(attrs \\ %{}) do
      {:ok, livestock_order_stage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LivestockOrderStages.create_livestock_order_stage()

      livestock_order_stage
    end

    test "list_livestock_order_stages/0 returns all livestock_order_stages" do
      livestock_order_stage = livestock_order_stage_fixture()
      assert LivestockOrderStages.list_livestock_order_stages() == [livestock_order_stage]
    end

    test "get_livestock_order_stage!/1 returns the livestock_order_stage with given id" do
      livestock_order_stage = livestock_order_stage_fixture()
      assert LivestockOrderStages.get_livestock_order_stage!(livestock_order_stage.id) == livestock_order_stage
    end

    test "create_livestock_order_stage/1 with valid data creates a livestock_order_stage" do
      assert {:ok, %LivestockOrderStage{} = livestock_order_stage} = LivestockOrderStages.create_livestock_order_stage(@valid_attrs)
      assert livestock_order_stage.stage_name == "some stage_name"
    end

    test "create_livestock_order_stage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LivestockOrderStages.create_livestock_order_stage(@invalid_attrs)
    end

    test "update_livestock_order_stage/2 with valid data updates the livestock_order_stage" do
      livestock_order_stage = livestock_order_stage_fixture()
      assert {:ok, livestock_order_stage} = LivestockOrderStages.update_livestock_order_stage(livestock_order_stage, @update_attrs)
      assert %LivestockOrderStage{} = livestock_order_stage
      assert livestock_order_stage.stage_name == "some updated stage_name"
    end

    test "update_livestock_order_stage/2 with invalid data returns error changeset" do
      livestock_order_stage = livestock_order_stage_fixture()
      assert {:error, %Ecto.Changeset{}} = LivestockOrderStages.update_livestock_order_stage(livestock_order_stage, @invalid_attrs)
      assert livestock_order_stage == LivestockOrderStages.get_livestock_order_stage!(livestock_order_stage.id)
    end

    test "delete_livestock_order_stage/1 deletes the livestock_order_stage" do
      livestock_order_stage = livestock_order_stage_fixture()
      assert {:ok, %LivestockOrderStage{}} = LivestockOrderStages.delete_livestock_order_stage(livestock_order_stage)
      assert_raise Ecto.NoResultsError, fn -> LivestockOrderStages.get_livestock_order_stage!(livestock_order_stage.id) end
    end

    test "change_livestock_order_stage/1 returns a livestock_order_stage changeset" do
      livestock_order_stage = livestock_order_stage_fixture()
      assert %Ecto.Changeset{} = LivestockOrderStages.change_livestock_order_stage(livestock_order_stage)
    end
  end
end
