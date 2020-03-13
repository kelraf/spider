defmodule Spider.TraincsTest do
  use Spider.DataCase

  alias Spider.Traincs

  describe "traincs" do
    alias Spider.Traincs.Trainc

    @valid_attrs %{role: "some role", unique_number: "some unique_number"}
    @update_attrs %{role: "some updated role", unique_number: "some updated unique_number"}
    @invalid_attrs %{role: nil, unique_number: nil}

    def trainc_fixture(attrs \\ %{}) do
      {:ok, trainc} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Traincs.create_trainc()

      trainc
    end

    test "list_traincs/0 returns all traincs" do
      trainc = trainc_fixture()
      assert Traincs.list_traincs() == [trainc]
    end

    test "get_trainc!/1 returns the trainc with given id" do
      trainc = trainc_fixture()
      assert Traincs.get_trainc!(trainc.id) == trainc
    end

    test "create_trainc/1 with valid data creates a trainc" do
      assert {:ok, %Trainc{} = trainc} = Traincs.create_trainc(@valid_attrs)
      assert trainc.role == "some role"
      assert trainc.unique_number == "some unique_number"
    end

    test "create_trainc/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Traincs.create_trainc(@invalid_attrs)
    end

    test "update_trainc/2 with valid data updates the trainc" do
      trainc = trainc_fixture()
      assert {:ok, trainc} = Traincs.update_trainc(trainc, @update_attrs)
      assert %Trainc{} = trainc
      assert trainc.role == "some updated role"
      assert trainc.unique_number == "some updated unique_number"
    end

    test "update_trainc/2 with invalid data returns error changeset" do
      trainc = trainc_fixture()
      assert {:error, %Ecto.Changeset{}} = Traincs.update_trainc(trainc, @invalid_attrs)
      assert trainc == Traincs.get_trainc!(trainc.id)
    end

    test "delete_trainc/1 deletes the trainc" do
      trainc = trainc_fixture()
      assert {:ok, %Trainc{}} = Traincs.delete_trainc(trainc)
      assert_raise Ecto.NoResultsError, fn -> Traincs.get_trainc!(trainc.id) end
    end

    test "change_trainc/1 returns a trainc changeset" do
      trainc = trainc_fixture()
      assert %Ecto.Changeset{} = Traincs.change_trainc(trainc)
    end
  end
end
