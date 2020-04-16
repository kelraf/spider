defmodule Spider.ERolesTest do
  use Spider.DataCase

  alias Spider.ERoles

  describe "eroles" do
    alias Spider.ERoles.ERole

    @valid_attrs %{capacity: 42}
    @update_attrs %{capacity: 43}
    @invalid_attrs %{capacity: nil}

    def e_role_fixture(attrs \\ %{}) do
      {:ok, e_role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ERoles.create_e_role()

      e_role
    end

    test "list_eroles/0 returns all eroles" do
      e_role = e_role_fixture()
      assert ERoles.list_eroles() == [e_role]
    end

    test "get_e_role!/1 returns the e_role with given id" do
      e_role = e_role_fixture()
      assert ERoles.get_e_role!(e_role.id) == e_role
    end

    test "create_e_role/1 with valid data creates a e_role" do
      assert {:ok, %ERole{} = e_role} = ERoles.create_e_role(@valid_attrs)
      assert e_role.capacity == 42
    end

    test "create_e_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ERoles.create_e_role(@invalid_attrs)
    end

    test "update_e_role/2 with valid data updates the e_role" do
      e_role = e_role_fixture()
      assert {:ok, e_role} = ERoles.update_e_role(e_role, @update_attrs)
      assert %ERole{} = e_role
      assert e_role.capacity == 43
    end

    test "update_e_role/2 with invalid data returns error changeset" do
      e_role = e_role_fixture()
      assert {:error, %Ecto.Changeset{}} = ERoles.update_e_role(e_role, @invalid_attrs)
      assert e_role == ERoles.get_e_role!(e_role.id)
    end

    test "delete_e_role/1 deletes the e_role" do
      e_role = e_role_fixture()
      assert {:ok, %ERole{}} = ERoles.delete_e_role(e_role)
      assert_raise Ecto.NoResultsError, fn -> ERoles.get_e_role!(e_role.id) end
    end

    test "change_e_role/1 returns a e_role changeset" do
      e_role = e_role_fixture()
      assert %Ecto.Changeset{} = ERoles.change_e_role(e_role)
    end
  end
end
