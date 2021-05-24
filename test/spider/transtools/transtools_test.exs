defmodule Spider.TranstoolsTest do
  use Spider.DataCase

  alias Spider.Transtools

  describe "transtools" do
    alias Spider.Transtools.Transtool

    @valid_attrs %{brand: "some brand", model: "some model", registration_number: "some registration_number", type: "some type"}
    @update_attrs %{brand: "some updated brand", model: "some updated model", registration_number: "some updated registration_number", type: "some updated type"}
    @invalid_attrs %{brand: nil, model: nil, registration_number: nil, type: nil}

    def transtool_fixture(attrs \\ %{}) do
      {:ok, transtool} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transtools.create_transtool()

      transtool
    end

    test "list_transtools/0 returns all transtools" do
      transtool = transtool_fixture()
      assert Transtools.list_transtools() == [transtool]
    end

    test "get_transtool!/1 returns the transtool with given id" do
      transtool = transtool_fixture()
      assert Transtools.get_transtool!(transtool.id) == transtool
    end

    test "create_transtool/1 with valid data creates a transtool" do
      assert {:ok, %Transtool{} = transtool} = Transtools.create_transtool(@valid_attrs)
      assert transtool.brand == "some brand"
      assert transtool.model == "some model"
      assert transtool.registration_number == "some registration_number"
      assert transtool.type == "some type"
    end

    test "create_transtool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transtools.create_transtool(@invalid_attrs)
    end

    test "update_transtool/2 with valid data updates the transtool" do
      transtool = transtool_fixture()
      assert {:ok, transtool} = Transtools.update_transtool(transtool, @update_attrs)
      assert %Transtool{} = transtool
      assert transtool.brand == "some updated brand"
      assert transtool.model == "some updated model"
      assert transtool.registration_number == "some updated registration_number"
      assert transtool.type == "some updated type"
    end

    test "update_transtool/2 with invalid data returns error changeset" do
      transtool = transtool_fixture()
      assert {:error, %Ecto.Changeset{}} = Transtools.update_transtool(transtool, @invalid_attrs)
      assert transtool == Transtools.get_transtool!(transtool.id)
    end

    test "delete_transtool/1 deletes the transtool" do
      transtool = transtool_fixture()
      assert {:ok, %Transtool{}} = Transtools.delete_transtool(transtool)
      assert_raise Ecto.NoResultsError, fn -> Transtools.get_transtool!(transtool.id) end
    end

    test "change_transtool/1 returns a transtool changeset" do
      transtool = transtool_fixture()
      assert %Ecto.Changeset{} = Transtools.change_transtool(transtool)
    end
  end
end
