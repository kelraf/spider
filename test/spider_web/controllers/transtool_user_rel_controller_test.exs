defmodule SpiderWeb.TranstoolUserRelControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.TranstoolUserRels
  alias Spider.TranstoolUserRels.TranstoolUserRel

  @create_attrs %{business_id: "some business_id", transtool_id: "some transtool_id", user_id: "some user_id"}
  @update_attrs %{business_id: "some updated business_id", transtool_id: "some updated transtool_id", user_id: "some updated user_id"}
  @invalid_attrs %{business_id: nil, transtool_id: nil, user_id: nil}

  def fixture(:transtool_user_rel) do
    {:ok, transtool_user_rel} = TranstoolUserRels.create_transtool_user_rel(@create_attrs)
    transtool_user_rel
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transtooluserrels", %{conn: conn} do
      conn = get conn, transtool_user_rel_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transtool_user_rel" do
    test "renders transtool_user_rel when data is valid", %{conn: conn} do
      conn = post conn, transtool_user_rel_path(conn, :create), transtool_user_rel: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, transtool_user_rel_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "business_id" => "some business_id",
        "transtool_id" => "some transtool_id",
        "user_id" => "some user_id"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, transtool_user_rel_path(conn, :create), transtool_user_rel: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transtool_user_rel" do
    setup [:create_transtool_user_rel]

    test "renders transtool_user_rel when data is valid", %{conn: conn, transtool_user_rel: %TranstoolUserRel{id: id} = transtool_user_rel} do
      conn = put conn, transtool_user_rel_path(conn, :update, transtool_user_rel), transtool_user_rel: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, transtool_user_rel_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "business_id" => "some updated business_id",
        "transtool_id" => "some updated transtool_id",
        "user_id" => "some updated user_id"}
    end

    test "renders errors when data is invalid", %{conn: conn, transtool_user_rel: transtool_user_rel} do
      conn = put conn, transtool_user_rel_path(conn, :update, transtool_user_rel), transtool_user_rel: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transtool_user_rel" do
    setup [:create_transtool_user_rel]

    test "deletes chosen transtool_user_rel", %{conn: conn, transtool_user_rel: transtool_user_rel} do
      conn = delete conn, transtool_user_rel_path(conn, :delete, transtool_user_rel)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, transtool_user_rel_path(conn, :show, transtool_user_rel)
      end
    end
  end

  defp create_transtool_user_rel(_) do
    transtool_user_rel = fixture(:transtool_user_rel)
    {:ok, transtool_user_rel: transtool_user_rel}
  end
end
