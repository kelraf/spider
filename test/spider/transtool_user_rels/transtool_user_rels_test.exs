defmodule Spider.TranstoolUserRelsTest do
  use Spider.DataCase

  alias Spider.TranstoolUserRels

  describe "transtooluserrels" do
    alias Spider.TranstoolUserRels.TranstoolUserRel

    @valid_attrs %{business_id: "some business_id", transtool_id: "some transtool_id", user_id: "some user_id"}
    @update_attrs %{business_id: "some updated business_id", transtool_id: "some updated transtool_id", user_id: "some updated user_id"}
    @invalid_attrs %{business_id: nil, transtool_id: nil, user_id: nil}

    def transtool_user_rel_fixture(attrs \\ %{}) do
      {:ok, transtool_user_rel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TranstoolUserRels.create_transtool_user_rel()

      transtool_user_rel
    end

    test "list_transtooluserrels/0 returns all transtooluserrels" do
      transtool_user_rel = transtool_user_rel_fixture()
      assert TranstoolUserRels.list_transtooluserrels() == [transtool_user_rel]
    end

    test "get_transtool_user_rel!/1 returns the transtool_user_rel with given id" do
      transtool_user_rel = transtool_user_rel_fixture()
      assert TranstoolUserRels.get_transtool_user_rel!(transtool_user_rel.id) == transtool_user_rel
    end

    test "create_transtool_user_rel/1 with valid data creates a transtool_user_rel" do
      assert {:ok, %TranstoolUserRel{} = transtool_user_rel} = TranstoolUserRels.create_transtool_user_rel(@valid_attrs)
      assert transtool_user_rel.business_id == "some business_id"
      assert transtool_user_rel.transtool_id == "some transtool_id"
      assert transtool_user_rel.user_id == "some user_id"
    end

    test "create_transtool_user_rel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TranstoolUserRels.create_transtool_user_rel(@invalid_attrs)
    end

    test "update_transtool_user_rel/2 with valid data updates the transtool_user_rel" do
      transtool_user_rel = transtool_user_rel_fixture()
      assert {:ok, transtool_user_rel} = TranstoolUserRels.update_transtool_user_rel(transtool_user_rel, @update_attrs)
      assert %TranstoolUserRel{} = transtool_user_rel
      assert transtool_user_rel.business_id == "some updated business_id"
      assert transtool_user_rel.transtool_id == "some updated transtool_id"
      assert transtool_user_rel.user_id == "some updated user_id"
    end

    test "update_transtool_user_rel/2 with invalid data returns error changeset" do
      transtool_user_rel = transtool_user_rel_fixture()
      assert {:error, %Ecto.Changeset{}} = TranstoolUserRels.update_transtool_user_rel(transtool_user_rel, @invalid_attrs)
      assert transtool_user_rel == TranstoolUserRels.get_transtool_user_rel!(transtool_user_rel.id)
    end

    test "delete_transtool_user_rel/1 deletes the transtool_user_rel" do
      transtool_user_rel = transtool_user_rel_fixture()
      assert {:ok, %TranstoolUserRel{}} = TranstoolUserRels.delete_transtool_user_rel(transtool_user_rel)
      assert_raise Ecto.NoResultsError, fn -> TranstoolUserRels.get_transtool_user_rel!(transtool_user_rel.id) end
    end

    test "change_transtool_user_rel/1 returns a transtool_user_rel changeset" do
      transtool_user_rel = transtool_user_rel_fixture()
      assert %Ecto.Changeset{} = TranstoolUserRels.change_transtool_user_rel(transtool_user_rel)
    end
  end
end
