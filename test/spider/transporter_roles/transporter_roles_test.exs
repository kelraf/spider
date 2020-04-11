defmodule Spider.TransporterRolesTest do
  use Spider.DataCase

  alias Spider.TransporterRoles

  describe "transporterroles" do
    alias Spider.TransporterRoles.TransporterRole

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def transporter_role_fixture(attrs \\ %{}) do
      {:ok, transporter_role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TransporterRoles.create_transporter_role()

      transporter_role
    end

    test "list_transporterroles/0 returns all transporterroles" do
      transporter_role = transporter_role_fixture()
      assert TransporterRoles.list_transporterroles() == [transporter_role]
    end

    test "get_transporter_role!/1 returns the transporter_role with given id" do
      transporter_role = transporter_role_fixture()
      assert TransporterRoles.get_transporter_role!(transporter_role.id) == transporter_role
    end

    test "create_transporter_role/1 with valid data creates a transporter_role" do
      assert {:ok, %TransporterRole{} = transporter_role} = TransporterRoles.create_transporter_role(@valid_attrs)
    end

    test "create_transporter_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TransporterRoles.create_transporter_role(@invalid_attrs)
    end

    test "update_transporter_role/2 with valid data updates the transporter_role" do
      transporter_role = transporter_role_fixture()
      assert {:ok, transporter_role} = TransporterRoles.update_transporter_role(transporter_role, @update_attrs)
      assert %TransporterRole{} = transporter_role
    end

    test "update_transporter_role/2 with invalid data returns error changeset" do
      transporter_role = transporter_role_fixture()
      assert {:error, %Ecto.Changeset{}} = TransporterRoles.update_transporter_role(transporter_role, @invalid_attrs)
      assert transporter_role == TransporterRoles.get_transporter_role!(transporter_role.id)
    end

    test "delete_transporter_role/1 deletes the transporter_role" do
      transporter_role = transporter_role_fixture()
      assert {:ok, %TransporterRole{}} = TransporterRoles.delete_transporter_role(transporter_role)
      assert_raise Ecto.NoResultsError, fn -> TransporterRoles.get_transporter_role!(transporter_role.id) end
    end

    test "change_transporter_role/1 returns a transporter_role changeset" do
      transporter_role = transporter_role_fixture()
      assert %Ecto.Changeset{} = TransporterRoles.change_transporter_role(transporter_role)
    end
  end
end
