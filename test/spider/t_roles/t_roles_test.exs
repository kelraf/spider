defmodule Spider.TRolesTest do
  use Spider.DataCase

  alias Spider.TRoles

  describe "troles" do
    alias Spider.TRoles.TRole

    @valid_attrs %{capacity: 42}
    @update_attrs %{capacity: 43}
    @invalid_attrs %{capacity: nil}

    def t_role_fixture(attrs \\ %{}) do
      {:ok, t_role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TRoles.create_t_role()

      t_role
    end

    test "list_troles/0 returns all troles" do
      t_role = t_role_fixture()
      assert TRoles.list_troles() == [t_role]
    end

    test "get_t_role!/1 returns the t_role with given id" do
      t_role = t_role_fixture()
      assert TRoles.get_t_role!(t_role.id) == t_role
    end

    test "create_t_role/1 with valid data creates a t_role" do
      assert {:ok, %TRole{} = t_role} = TRoles.create_t_role(@valid_attrs)
      assert t_role.capacity == 42
    end

    test "create_t_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TRoles.create_t_role(@invalid_attrs)
    end

    test "update_t_role/2 with valid data updates the t_role" do
      t_role = t_role_fixture()
      assert {:ok, t_role} = TRoles.update_t_role(t_role, @update_attrs)
      assert %TRole{} = t_role
      assert t_role.capacity == 43
    end

    test "update_t_role/2 with invalid data returns error changeset" do
      t_role = t_role_fixture()
      assert {:error, %Ecto.Changeset{}} = TRoles.update_t_role(t_role, @invalid_attrs)
      assert t_role == TRoles.get_t_role!(t_role.id)
    end

    test "delete_t_role/1 deletes the t_role" do
      t_role = t_role_fixture()
      assert {:ok, %TRole{}} = TRoles.delete_t_role(t_role)
      assert_raise Ecto.NoResultsError, fn -> TRoles.get_t_role!(t_role.id) end
    end

    test "change_t_role/1 returns a t_role changeset" do
      t_role = t_role_fixture()
      assert %Ecto.Changeset{} = TRoles.change_t_role(t_role)
    end
  end
end
