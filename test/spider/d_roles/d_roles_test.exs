defmodule Spider.DRolesTest do
  use Spider.DataCase

  alias Spider.DRoles

  describe "droles" do
    alias Spider.DRoles.DRole

    @valid_attrs %{role: "some role"}
    @update_attrs %{role: "some updated role"}
    @invalid_attrs %{role: nil}

    def d_role_fixture(attrs \\ %{}) do
      {:ok, d_role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DRoles.create_d_role()

      d_role
    end

    test "list_droles/0 returns all droles" do
      d_role = d_role_fixture()
      assert DRoles.list_droles() == [d_role]
    end

    test "get_d_role!/1 returns the d_role with given id" do
      d_role = d_role_fixture()
      assert DRoles.get_d_role!(d_role.id) == d_role
    end

    test "create_d_role/1 with valid data creates a d_role" do
      assert {:ok, %DRole{} = d_role} = DRoles.create_d_role(@valid_attrs)
      assert d_role.role == "some role"
    end

    test "create_d_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DRoles.create_d_role(@invalid_attrs)
    end

    test "update_d_role/2 with valid data updates the d_role" do
      d_role = d_role_fixture()
      assert {:ok, d_role} = DRoles.update_d_role(d_role, @update_attrs)
      assert %DRole{} = d_role
      assert d_role.role == "some updated role"
    end

    test "update_d_role/2 with invalid data returns error changeset" do
      d_role = d_role_fixture()
      assert {:error, %Ecto.Changeset{}} = DRoles.update_d_role(d_role, @invalid_attrs)
      assert d_role == DRoles.get_d_role!(d_role.id)
    end

    test "delete_d_role/1 deletes the d_role" do
      d_role = d_role_fixture()
      assert {:ok, %DRole{}} = DRoles.delete_d_role(d_role)
      assert_raise Ecto.NoResultsError, fn -> DRoles.get_d_role!(d_role.id) end
    end

    test "change_d_role/1 returns a d_role changeset" do
      d_role = d_role_fixture()
      assert %Ecto.Changeset{} = DRoles.change_d_role(d_role)
    end
  end
end
