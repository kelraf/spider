defmodule Spider.TransportersTest do
  use Spider.DataCase

  alias Spider.Transporters

  describe "transporters" do
    alias Spider.Transporters.Transporter

    @valid_attrs %{latitude_from: "some latitude_from", latitude_to: "some latitude_to", logitude_from: "some logitude_from", longitude_to: "some longitude_to", status: 42, transporter_id: 42}
    @update_attrs %{latitude_from: "some updated latitude_from", latitude_to: "some updated latitude_to", logitude_from: "some updated logitude_from", longitude_to: "some updated longitude_to", status: 43, transporter_id: 43}
    @invalid_attrs %{latitude_from: nil, latitude_to: nil, logitude_from: nil, longitude_to: nil, status: nil, transporter_id: nil}

    def transporter_fixture(attrs \\ %{}) do
      {:ok, transporter} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transporters.create_transporter()

      transporter
    end

    test "list_transporters/0 returns all transporters" do
      transporter = transporter_fixture()
      assert Transporters.list_transporters() == [transporter]
    end

    test "get_transporter!/1 returns the transporter with given id" do
      transporter = transporter_fixture()
      assert Transporters.get_transporter!(transporter.id) == transporter
    end

    test "create_transporter/1 with valid data creates a transporter" do
      assert {:ok, %Transporter{} = transporter} = Transporters.create_transporter(@valid_attrs)
      assert transporter.latitude_from == "some latitude_from"
      assert transporter.latitude_to == "some latitude_to"
      assert transporter.logitude_from == "some logitude_from"
      assert transporter.longitude_to == "some longitude_to"
      assert transporter.status == 42
      assert transporter.transporter_id == 42
    end

    test "create_transporter/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transporters.create_transporter(@invalid_attrs)
    end

    test "update_transporter/2 with valid data updates the transporter" do
      transporter = transporter_fixture()
      assert {:ok, transporter} = Transporters.update_transporter(transporter, @update_attrs)
      assert %Transporter{} = transporter
      assert transporter.latitude_from == "some updated latitude_from"
      assert transporter.latitude_to == "some updated latitude_to"
      assert transporter.logitude_from == "some updated logitude_from"
      assert transporter.longitude_to == "some updated longitude_to"
      assert transporter.status == 43
      assert transporter.transporter_id == 43
    end

    test "update_transporter/2 with invalid data returns error changeset" do
      transporter = transporter_fixture()
      assert {:error, %Ecto.Changeset{}} = Transporters.update_transporter(transporter, @invalid_attrs)
      assert transporter == Transporters.get_transporter!(transporter.id)
    end

    test "delete_transporter/1 deletes the transporter" do
      transporter = transporter_fixture()
      assert {:ok, %Transporter{}} = Transporters.delete_transporter(transporter)
      assert_raise Ecto.NoResultsError, fn -> Transporters.get_transporter!(transporter.id) end
    end

    test "change_transporter/1 returns a transporter changeset" do
      transporter = transporter_fixture()
      assert %Ecto.Changeset{} = Transporters.change_transporter(transporter)
    end
  end
end
