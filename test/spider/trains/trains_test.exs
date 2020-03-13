defmodule Spider.TrainsTest do
  use Spider.DataCase

  alias Spider.Trains

  describe "trains" do
    alias Spider.Trains.Train

    @valid_attrs %{unique_number: "some unique_number"}
    @update_attrs %{unique_number: "some updated unique_number"}
    @invalid_attrs %{unique_number: nil}

    def train_fixture(attrs \\ %{}) do
      {:ok, train} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trains.create_train()

      train
    end

    test "list_trains/0 returns all trains" do
      train = train_fixture()
      assert Trains.list_trains() == [train]
    end

    test "get_train!/1 returns the train with given id" do
      train = train_fixture()
      assert Trains.get_train!(train.id) == train
    end

    test "create_train/1 with valid data creates a train" do
      assert {:ok, %Train{} = train} = Trains.create_train(@valid_attrs)
      assert train.unique_number == "some unique_number"
    end

    test "create_train/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trains.create_train(@invalid_attrs)
    end

    test "update_train/2 with valid data updates the train" do
      train = train_fixture()
      assert {:ok, train} = Trains.update_train(train, @update_attrs)
      assert %Train{} = train
      assert train.unique_number == "some updated unique_number"
    end

    test "update_train/2 with invalid data returns error changeset" do
      train = train_fixture()
      assert {:error, %Ecto.Changeset{}} = Trains.update_train(train, @invalid_attrs)
      assert train == Trains.get_train!(train.id)
    end

    test "delete_train/1 deletes the train" do
      train = train_fixture()
      assert {:ok, %Train{}} = Trains.delete_train(train)
      assert_raise Ecto.NoResultsError, fn -> Trains.get_train!(train.id) end
    end

    test "change_train/1 returns a train changeset" do
      train = train_fixture()
      assert %Ecto.Changeset{} = Trains.change_train(train)
    end
  end

  describe "trains" do
    alias Spider.Trains.Train

    @valid_attrs %{role: "some role", unique_number: "some unique_number"}
    @update_attrs %{role: "some updated role", unique_number: "some updated unique_number"}
    @invalid_attrs %{role: nil, unique_number: nil}

    def train_fixture(attrs \\ %{}) do
      {:ok, train} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trains.create_train()

      train
    end

    test "list_trains/0 returns all trains" do
      train = train_fixture()
      assert Trains.list_trains() == [train]
    end

    test "get_train!/1 returns the train with given id" do
      train = train_fixture()
      assert Trains.get_train!(train.id) == train
    end

    test "create_train/1 with valid data creates a train" do
      assert {:ok, %Train{} = train} = Trains.create_train(@valid_attrs)
      assert train.role == "some role"
      assert train.unique_number == "some unique_number"
    end

    test "create_train/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trains.create_train(@invalid_attrs)
    end

    test "update_train/2 with valid data updates the train" do
      train = train_fixture()
      assert {:ok, train} = Trains.update_train(train, @update_attrs)
      assert %Train{} = train
      assert train.role == "some updated role"
      assert train.unique_number == "some updated unique_number"
    end

    test "update_train/2 with invalid data returns error changeset" do
      train = train_fixture()
      assert {:error, %Ecto.Changeset{}} = Trains.update_train(train, @invalid_attrs)
      assert train == Trains.get_train!(train.id)
    end

    test "delete_train/1 deletes the train" do
      train = train_fixture()
      assert {:ok, %Train{}} = Trains.delete_train(train)
      assert_raise Ecto.NoResultsError, fn -> Trains.get_train!(train.id) end
    end

    test "change_train/1 returns a train changeset" do
      train = train_fixture()
      assert %Ecto.Changeset{} = Trains.change_train(train)
    end
  end
end
