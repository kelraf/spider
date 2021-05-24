defmodule Spider.VReqsTest do
  use Spider.DataCase

  alias Spider.VReqs

  describe "vreqs" do
    alias Spider.VReqs.VReq

    @valid_attrs %{available: true}
    @update_attrs %{available: false}
    @invalid_attrs %{available: nil}

    def v_req_fixture(attrs \\ %{}) do
      {:ok, v_req} =
        attrs
        |> Enum.into(@valid_attrs)
        |> VReqs.create_v_req()

      v_req
    end

    test "list_vreqs/0 returns all vreqs" do
      v_req = v_req_fixture()
      assert VReqs.list_vreqs() == [v_req]
    end

    test "get_v_req!/1 returns the v_req with given id" do
      v_req = v_req_fixture()
      assert VReqs.get_v_req!(v_req.id) == v_req
    end

    test "create_v_req/1 with valid data creates a v_req" do
      assert {:ok, %VReq{} = v_req} = VReqs.create_v_req(@valid_attrs)
      assert v_req.available == true
    end

    test "create_v_req/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = VReqs.create_v_req(@invalid_attrs)
    end

    test "update_v_req/2 with valid data updates the v_req" do
      v_req = v_req_fixture()
      assert {:ok, v_req} = VReqs.update_v_req(v_req, @update_attrs)
      assert %VReq{} = v_req
      assert v_req.available == false
    end

    test "update_v_req/2 with invalid data returns error changeset" do
      v_req = v_req_fixture()
      assert {:error, %Ecto.Changeset{}} = VReqs.update_v_req(v_req, @invalid_attrs)
      assert v_req == VReqs.get_v_req!(v_req.id)
    end

    test "delete_v_req/1 deletes the v_req" do
      v_req = v_req_fixture()
      assert {:ok, %VReq{}} = VReqs.delete_v_req(v_req)
      assert_raise Ecto.NoResultsError, fn -> VReqs.get_v_req!(v_req.id) end
    end

    test "change_v_req/1 returns a v_req changeset" do
      v_req = v_req_fixture()
      assert %Ecto.Changeset{} = VReqs.change_v_req(v_req)
    end
  end
end
