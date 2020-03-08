defmodule Spider.UserToolKit do

  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Repo
  alias Spider.Accounts.User

  def password_hash(changeset) do
    case get_field(changeset, :raw_password) do
      nil ->
        changeset
        raw_password ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(raw_password))
    end
  end

  def password_confirm(changeset) do
    case get_field(changeset, :raw_password) do
      nil ->
        changeset

      raw_password ->
        case get_field(changeset, :confirm_password) do
          nil ->
            changeset

          confirm_password ->
            if raw_password != confirm_password do
              add_error(changeset, :confirm_password, "Your Passwords must match")
            else
              changeset
            end
        end
    end
  end

  def validate_roles(changeset) do

    case get_field(changeset, :role) do
      "spider-010-norm" -> 
        changeset
      "group_business_creator" -> 
        changeset
      "group_member" ->
        changeset
      "multi" -> 
        changeset
      "driver" -> 
        changeset
      nil ->
          changeset
      _ -> 
        add_error(changeset, :role, "Invalid role")
    end

  end

  # def set_verification_code(changeset) do
  #   case get_field(changeset, :raw_password) do
  #     nil ->
  #       changeset
  #     raw_password ->
  #       put_change(changeset, :verification_code, raw_password)
  #   end
  # end

  # def create_account_using_role(create_results) do

  #   case create_results do
  #     {:error, _changeset} -> 
  #       create_results
  #     {:ok, results} -> 
  #       case Map.get(results, :role) do
  #         "admin" -> 
  #           create_results
  #         "waiter" -> 
  #           waiter_creation = WaitersBusinessRelations.create_waiters_business_relation(%{business_id: Map.get(results, :business_id), user_id: Map.get(results, :id)})
  #           Map.put(elem(create_results, 1), :waiter_relations, waiter_creation)

  #       end
  #   end
  # end


  def get_user_by_phone(%{"phone_number" => phone_number}) do
    user = Repo.get_by(User, phone_number: phone_number)

    case user do
      nil -> 
        {:error, "User Not Found"}
      _ ->
        {:ok, user}
    end

  end

end