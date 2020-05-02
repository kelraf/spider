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
      current_password = get_field(changeset, :current_password)
      current_password_hash = get_field(changeset, :current_password_hash)

      if raw_password == nil and confirm_password == nil or password_hash == nil do
        changeset
      else
        cond do
          byte_size(raw_password) < 6 ->
            add_error(changeset, :raw_password, "Your password is too short")
          raw_password !== confirm_password ->
            add_error(changeset, :raw_password, "Your passwords must match")
          current_password_hash == nil ->
            add_error(changeset, :current_password_hash, "Oops Something Went Wrong")
          current_password |> Comeonin.Bcrypt.checkpw(current_password_hash) !== true ->
            add_error(changeset, :current_password, "Current Password is Invalid")
          true -> 
            put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(raw_password))
        end

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
      "spider-trader-001" -> 
        changeset
      "spider-buyer-001" -> 
        changeset
      "spider-business-member" ->
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

  # ensure that the email looks valid
  def validate_email(email) when is_binary(email) do
    case Regex.run(~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i, email) do
      nil ->
        {:error, "Invalid email"}
      [email] ->
        try do
          Regex.run(~r/(\w+)@([\w.]+)/, email) |> validate_email
        rescue
          _ -> {:error, "Invalid email"}
        end
    end
  end

end