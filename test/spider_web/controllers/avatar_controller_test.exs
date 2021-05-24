defmodule SpiderWeb.AvatarControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Avatars
  alias Spider.Avatars.Avatar

  @create_attrs %{avatar: "some avatar"}
  @update_attrs %{avatar: "some updated avatar"}
  @invalid_attrs %{avatar: nil}

  def fixture(:avatar) do
    {:ok, avatar} = Avatars.create_avatar(@create_attrs)
    avatar
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all avatars", %{conn: conn} do
      conn = get conn, avatar_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create avatar" do
    test "renders avatar when data is valid", %{conn: conn} do
      conn = post conn, avatar_path(conn, :create), avatar: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, avatar_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "avatar" => "some avatar"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, avatar_path(conn, :create), avatar: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update avatar" do
    setup [:create_avatar]

    test "renders avatar when data is valid", %{conn: conn, avatar: %Avatar{id: id} = avatar} do
      conn = put conn, avatar_path(conn, :update, avatar), avatar: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, avatar_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "avatar" => "some updated avatar"}
    end

    test "renders errors when data is invalid", %{conn: conn, avatar: avatar} do
      conn = put conn, avatar_path(conn, :update, avatar), avatar: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete avatar" do
    setup [:create_avatar]

    test "deletes chosen avatar", %{conn: conn, avatar: avatar} do
      conn = delete conn, avatar_path(conn, :delete, avatar)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, avatar_path(conn, :show, avatar)
      end
    end
  end

  defp create_avatar(_) do
    avatar = fixture(:avatar)
    {:ok, avatar: avatar}
  end
end
