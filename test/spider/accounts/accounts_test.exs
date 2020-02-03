defmodule Spider.AccountsTest do
  use Spider.DataCase

  alias Spider.Accounts

  describe "users" do
    alias Spider.Accounts.User

    @valid_attrs %{email: "some email", first_name: "some first_name", kra_pin: "some kra_pin", last_name: "some last_name", national_id_number: 42, password_hash: "some password_hash", phone_number: "some phone_number", role: 42, verification_code: 42}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", kra_pin: "some updated kra_pin", last_name: "some updated last_name", national_id_number: 43, password_hash: "some updated password_hash", phone_number: "some updated phone_number", role: 43, verification_code: 43}
    @invalid_attrs %{email: nil, first_name: nil, kra_pin: nil, last_name: nil, national_id_number: nil, password_hash: nil, phone_number: nil, role: nil, verification_code: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.kra_pin == "some kra_pin"
      assert user.last_name == "some last_name"
      assert user.national_id_number == 42
      assert user.password_hash == "some password_hash"
      assert user.phone_number == "some phone_number"
      assert user.role == 42
      assert user.verification_code == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.kra_pin == "some updated kra_pin"
      assert user.last_name == "some updated last_name"
      assert user.national_id_number == 43
      assert user.password_hash == "some updated password_hash"
      assert user.phone_number == "some updated phone_number"
      assert user.role == 43
      assert user.verification_code == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
