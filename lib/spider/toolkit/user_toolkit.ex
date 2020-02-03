defmodule Spider.UserToolKit do

  use Ecto.Schema
  import Ecto.Changeset

  def password_hash(changeset) do
    case get_field(changeset, :raw_password) do
      nil ->
        changeset
        raw_password ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(raw_password))
    end
  end

  def validate_roles(changeset) do

    case get_field(changeset, :role) do
      1 -> 
        changeset
      2 -> 
        changeset
      3 ->
        changeset
      4 -> 
        changeset
      5 -> 
        changeset
      6 -> 
        changeset
      7 -> 
        changeset
      nil ->
          changeset
      _ -> 
        add_error(changeset, :role, "Invalid Role")
    end

  end

  def set_verification_code(changeset) do
    case get_field(changeset, :raw_password) do
      nil ->
        changeset
      raw_password ->
        put_change(changeset, :verification_code, raw_password)
    end
  end

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

end