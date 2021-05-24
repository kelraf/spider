defmodule Spider.DReqsTest do
  use Spider.DataCase

  alias Spider.DReqs

  describe "dreqs" do
    alias Spider.DReqs.DReq

    @valid_attrs %{requirement: "some requirement"}
    @update_attrs %{requirement: "some updated requirement"}
    @invalid_attrs %{requirement: nil}

    def d_req_fixture(attrs \\ %{}) do
      {:ok, d_req} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DReqs.create_d_req()

      d_req
    end

    test "list_dreqs/0 returns all dreqs" do
      d_req = d_req_fixture()
      assert DReqs.list_dreqs() == [d_req]
    end

    test "get_d_req!/1 returns the d_req with given id" do
      d_req = d_req_fixture()
      assert DReqs.get_d_req!(d_req.id) == d_req
    end

    test "create_d_req/1 with valid data creates a d_req" do
      assert {:ok, %DReq{} = d_req} = DReqs.create_d_req(@valid_attrs)
      assert d_req.requirement == "some requirement"
    end

    test "create_d_req/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DReqs.create_d_req(@invalid_attrs)
    end

    test "update_d_req/2 with valid data updates the d_req" do
      d_req = d_req_fixture()
      assert {:ok, d_req} = DReqs.update_d_req(d_req, @update_attrs)
      assert %DReq{} = d_req
      assert d_req.requirement == "some updated requirement"
    end

    test "update_d_req/2 with invalid data returns error changeset" do
      d_req = d_req_fixture()
      assert {:error, %Ecto.Changeset{}} = DReqs.update_d_req(d_req, @invalid_attrs)
      assert d_req == DReqs.get_d_req!(d_req.id)
    end

    test "delete_d_req/1 deletes the d_req" do
      d_req = d_req_fixture()
      assert {:ok, %DReq{}} = DReqs.delete_d_req(d_req)
      assert_raise Ecto.NoResultsError, fn -> DReqs.get_d_req!(d_req.id) end
    end

    test "change_d_req/1 returns a d_req changeset" do
      d_req = d_req_fixture()
      assert %Ecto.Changeset{} = DReqs.change_d_req(d_req)
    end
  end
end
