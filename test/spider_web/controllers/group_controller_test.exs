defmodule SpiderWeb.GroupControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Groups
  alias Spider.Groups.Group

  @create_attrs %{business_id: "some business_id", status: true, user_id: "some user_id"}
  @update_attrs %{business_id: "some updated business_id", status: false, user_id: "some updated user_id"}
  @invalid_attrs %{business_id: nil, status: nil, user_id: nil}

  def fixture(:group) do
    {:ok, group} = Groups.create_group(@create_attrs)
    group
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all groups", %{conn: conn} do
      conn = get conn, group_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create group" do
    test "renders group when data is valid", %{conn: conn} do
      conn = post conn, group_path(conn, :create), group: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, group_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "business_id" => "some business_id",
        "status" => true,
        "user_id" => "some user_id"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, group_path(conn, :create), group: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update group" do
    setup [:create_group]

    test "renders group when data is valid", %{conn: conn, group: %Group{id: id} = group} do
      conn = put conn, group_path(conn, :update, group), group: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, group_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "business_id" => "some updated business_id",
        "status" => false,
        "user_id" => "some updated user_id"}
    end

    test "renders errors when data is invalid", %{conn: conn, group: group} do
      conn = put conn, group_path(conn, :update, group), group: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete group" do
    setup [:create_group]

    test "deletes chosen group", %{conn: conn, group: group} do
      conn = delete conn, group_path(conn, :delete, group)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, group_path(conn, :show, group)
      end
    end
  end

  defp create_group(_) do
    group = fixture(:group)
    {:ok, group: group}
  end
end
