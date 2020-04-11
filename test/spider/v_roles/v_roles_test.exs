defmodule Spider.VRolesTest do
  use Spider.DataCase

  alias Spider.VRoles

  describe "vroles" do
    alias Spider.VRoles.VRole

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def v_role_fixture(attrs \\ %{}) do
      {:ok, v_role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> VRoles.create_v_role()

      v_role
    end

    test "list_vroles/0 returns all vroles" do
      v_role = v_role_fixture()
      assert VRoles.list_vroles() == [v_role]
    end

    test "get_v_role!/1 returns the v_role with given id" do
      v_role = v_role_fixture()
      assert VRoles.get_v_role!(v_role.id) == v_role
    end

    test "create_v_role/1 with valid data creates a v_role" do
      assert {:ok, %VRole{} = v_role} = VRoles.create_v_role(@valid_attrs)
    end

    test "create_v_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = VRoles.create_v_role(@invalid_attrs)
    end

    test "update_v_role/2 with valid data updates the v_role" do
      v_role = v_role_fixture()
      assert {:ok, v_role} = VRoles.update_v_role(v_role, @update_attrs)
      assert %VRole{} = v_role
    end

    test "update_v_role/2 with invalid data returns error changeset" do
      v_role = v_role_fixture()
      assert {:error, %Ecto.Changeset{}} = VRoles.update_v_role(v_role, @invalid_attrs)
      assert v_role == VRoles.get_v_role!(v_role.id)
    end

    test "delete_v_role/1 deletes the v_role" do
      v_role = v_role_fixture()
      assert {:ok, %VRole{}} = VRoles.delete_v_role(v_role)
      assert_raise Ecto.NoResultsError, fn -> VRoles.get_v_role!(v_role.id) end
    end

    test "change_v_role/1 returns a v_role changeset" do
      v_role = v_role_fixture()
      assert %Ecto.Changeset{} = VRoles.change_v_role(v_role)
    end
  end
end
