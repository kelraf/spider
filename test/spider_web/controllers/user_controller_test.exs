defmodule SpiderWeb.UserControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Accounts
  alias Spider.Accounts.User

  @create_attrs %{email: "some email", first_name: "some first_name", kra_pin: "some kra_pin", last_name: "some last_name", national_id_number: 42, password_hash: "some password_hash", phone_number: "some phone_number", role: 42, verification_code: 42}
  @update_attrs %{email: "some updated email", first_name: "some updated first_name", kra_pin: "some updated kra_pin", last_name: "some updated last_name", national_id_number: 43, password_hash: "some updated password_hash", phone_number: "some updated phone_number", role: 43, verification_code: 43}
  @invalid_attrs %{email: nil, first_name: nil, kra_pin: nil, last_name: nil, national_id_number: nil, password_hash: nil, phone_number: nil, role: nil, verification_code: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, user_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, user_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "email" => "some email",
        "first_name" => "some first_name",
        "kra_pin" => "some kra_pin",
        "last_name" => "some last_name",
        "national_id_number" => 42,
        "password_hash" => "some password_hash",
        "phone_number" => "some phone_number",
        "role" => 42,
        "verification_code" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put conn, user_path(conn, :update, user), user: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, user_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "email" => "some updated email",
        "first_name" => "some updated first_name",
        "kra_pin" => "some updated kra_pin",
        "last_name" => "some updated last_name",
        "national_id_number" => 43,
        "password_hash" => "some updated password_hash",
        "phone_number" => "some updated phone_number",
        "role" => 43,
        "verification_code" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete conn, user_path(conn, :delete, user)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, user_path(conn, :show, user)
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
