defmodule Spider.UserToolKit do
  use Ecto.Schema
  import Ecto.Changeset

  alias Retail.WaitersBusinessRelations

  def password_hash(changeset) do
    case get_field(changeset, :password) do
      nil ->
        changeset

      password ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
    end
  end

  def password_confirm(changeset) do
    case get_field(changeset, :password) do
      nil ->
        changeset

      password ->
        case get_field(changeset, :confirm_password) do
          nil ->
            changeset

          confirm_password ->
            if password != confirm_password do
              add_error(changeset, :confirm_password, "Your Passwords must match")
            else
              changeset
            end
        end
    end
  end

  def validate_roles(changeset) do

    case get_field(changeset, :role) do
      "admin" -> 
          changeset
      "waiter" -> 
          case get_field(changeset, :business_id) do
            nil -> 
              add_error(changeset, :business_id, "Business Id Required")
            _business_id -> 
              changeset
          end
      nil ->
          changeset
      _ -> 
        add_error(changeset, :role, "Invalid Role")
    end

  end

  def create_account_using_role(create_results) do

    case create_results do
      {:error, _changeset} -> 
        create_results
      {:ok, results} -> 
        case Map.get(results, :role) do
          "admin" -> 
            create_results
          "waiter" -> 
            waiter_creation = WaitersBusinessRelations.create_waiters_business_relation(%{business_id: Map.get(results, :business_id), user_id: Map.get(results, :id)})
            Map.put(elem(create_results, 1), :waiter_relations, waiter_creation)

        end
    end
  end

end