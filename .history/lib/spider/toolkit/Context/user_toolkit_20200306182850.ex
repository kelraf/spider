defmodule Spider.UserToolKit do

  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Repo
  alias Spider.Accounts.User

  def password_hash(changeset, action) do

    if action == "normal" do

      case get_field(changeset, :raw_password) do
        nil ->
          changeset
        raw_password ->
          put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(raw_password))
      end

    else
      changeset
    end
    
  end

  def passwords(changeset, action) do
    if action == "update" do

      raw_password = get_field(changeset, :raw_password)
      confirm_password = get_field(changeset, :confirm_password)
      password_hash = get_field(changeset, :password_hash)

      IO.inspect changeset

      if byte_size(raw_password) == 0 and byte_size(confirm_password) == 0 and byte_size(password_hash) > 0 do
        changeset
      else
        changeset
      end

    else

      case get_field(changeset, :raw_password) do
        nil ->
          add_error(changeset, :raw_password, "raw password can't be blank")
        raw_password ->

          case get_field(changeset, :confirm_password) do
            nil ->

              add_error(changeset, :confirm_password, "confirm password can't be blank")
              
            confirm_password ->

              cond do
                byte_size(raw_password) < 6 ->

                  add_error(changeset, :raw_password, "password too short")

                raw_password !== confirm_password ->

                  add_error(changeset, :confirm_password, "Your Passwords Must Match") 

                true ->

                  put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(raw_password))

              end

          end

      end

    end
  end

  def password_confirm(changeset, action) do
    if action == "normal" do

      case get_field(changeset, :raw_password) do
        nil ->
          add_error(changeset, :raw_password, "raw password require")
  
        raw_password ->
          case get_field(changeset, :confirm_password) do
            nil ->
              add_error(changeset, :confirm_password, "confirm password require")
  
            confirm_password ->
              if raw_password != confirm_password do
                add_error(changeset, :confirm_password, "Your Passwords must match")
              else
                changeset
              end
          end
      end

    else

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

  def get_user_by_phone(%{"phone_number" => phone_number}, check_status, what_to_check \\ 0) do

    user = Repo.get_by(User, phone_number: phone_number)

    case user do
      nil -> 
        {:error, "User Not Found"}
      _ ->
        if check_status do
          if user.status == what_to_check do
            {:ok, user}
          else
            {:error, user}
          end
        else
          {:ok, user}
        end
    end

  end

end