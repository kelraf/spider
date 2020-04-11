defmodule Spider.AdminTransporterRolesTest do
  use Spider.DataCase

  alias Spider.AdminTransporterRoles

  describe "admintransporterroles" do
    alias Spider.AdminTransporterRoles.AdminTransporterRole

    @valid_attrs %{role: "some role"}
    @update_attrs %{role: "some updated role"}
    @invalid_attrs %{role: nil}

    def admin_transporter_role_fixture(attrs \\ %{}) do
      {:ok, admin_transporter_role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AdminTransporterRoles.create_admin_transporter_role()

      admin_transporter_role
    end

    test "list_admintransporterroles/0 returns all admintransporterroles" do
      admin_transporter_role = admin_transporter_role_fixture()
      assert AdminTransporterRoles.list_admintransporterroles() == [admin_transporter_role]
    end

    test "get_admin_transporter_role!/1 returns the admin_transporter_role with given id" do
      admin_transporter_role = admin_transporter_role_fixture()
      assert AdminTransporterRoles.get_admin_transporter_role!(admin_transporter_role.id) == admin_transporter_role
    end

    test "create_admin_transporter_role/1 with valid data creates a admin_transporter_role" do
      assert {:ok, %AdminTransporterRole{} = admin_transporter_role} = AdminTransporterRoles.create_admin_transporter_role(@valid_attrs)
      assert admin_transporter_role.role == "some role"
    end

    test "create_admin_transporter_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AdminTransporterRoles.create_admin_transporter_role(@invalid_attrs)
    end

    test "update_admin_transporter_role/2 with valid data updates the admin_transporter_role" do
      admin_transporter_role = admin_transporter_role_fixture()
      assert {:ok, admin_transporter_role} = AdminTransporterRoles.update_admin_transporter_role(admin_transporter_role, @update_attrs)
      assert %AdminTransporterRole{} = admin_transporter_role
      assert admin_transporter_role.role == "some updated role"
    end

    test "update_admin_transporter_role/2 with invalid data returns error changeset" do
      admin_transporter_role = admin_transporter_role_fixture()
      assert {:error, %Ecto.Changeset{}} = AdminTransporterRoles.update_admin_transporter_role(admin_transporter_role, @invalid_attrs)
      assert admin_transporter_role == AdminTransporterRoles.get_admin_transporter_role!(admin_transporter_role.id)
    end

    test "delete_admin_transporter_role/1 deletes the admin_transporter_role" do
      admin_transporter_role = admin_transporter_role_fixture()
      assert {:ok, %AdminTransporterRole{}} = AdminTransporterRoles.delete_admin_transporter_role(admin_transporter_role)
      assert_raise Ecto.NoResultsError, fn -> AdminTransporterRoles.get_admin_transporter_role!(admin_transporter_role.id) end
    end

    test "change_admin_transporter_role/1 returns a admin_transporter_role changeset" do
      admin_transporter_role = admin_transporter_role_fixture()
      assert %Ecto.Changeset{} = AdminTransporterRoles.change_admin_transporter_role(admin_transporter_role)
    end
  end
end
