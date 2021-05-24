defmodule Spider.FrolesTest do
  use Spider.DataCase

  alias Spider.Froles

  describe "froles" do
    alias Spider.Froles.Frole

    @valid_attrs %{capacity: 42}
    @update_attrs %{capacity: 43}
    @invalid_attrs %{capacity: nil}

    def frole_fixture(attrs \\ %{}) do
      {:ok, frole} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Froles.create_frole()

      frole
    end

    test "list_froles/0 returns all froles" do
      frole = frole_fixture()
      assert Froles.list_froles() == [frole]
    end

    test "get_frole!/1 returns the frole with given id" do
      frole = frole_fixture()
      assert Froles.get_frole!(frole.id) == frole
    end

    test "create_frole/1 with valid data creates a frole" do
      assert {:ok, %Frole{} = frole} = Froles.create_frole(@valid_attrs)
      assert frole.capacity == 42
    end

    test "create_frole/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Froles.create_frole(@invalid_attrs)
    end

    test "update_frole/2 with valid data updates the frole" do
      frole = frole_fixture()
      assert {:ok, frole} = Froles.update_frole(frole, @update_attrs)
      assert %Frole{} = frole
      assert frole.capacity == 43
    end

    test "update_frole/2 with invalid data returns error changeset" do
      frole = frole_fixture()
      assert {:error, %Ecto.Changeset{}} = Froles.update_frole(frole, @invalid_attrs)
      assert frole == Froles.get_frole!(frole.id)
    end

    test "delete_frole/1 deletes the frole" do
      frole = frole_fixture()
      assert {:ok, %Frole{}} = Froles.delete_frole(frole)
      assert_raise Ecto.NoResultsError, fn -> Froles.get_frole!(frole.id) end
    end

    test "change_frole/1 returns a frole changeset" do
      frole = frole_fixture()
      assert %Ecto.Changeset{} = Froles.change_frole(frole)
    end
  end
end
