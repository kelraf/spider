defmodule Spider.Auth do

    import Ecto.Query, only: [from: 2]

    alias Spider.Accounts.User
    alias Spider.Repo

    def login(user_credentials = %{"phone_number" => phone_number, "password" => password}) do
        
        case Repo.get_by(User, phone_number: phone_number) do
            nil -> 
                {:error, "Invalid Credentials: 00100"}
            user -> 
                if password |> Comeonin.Bcrypt.checkpw(user.password_hash) do
                    {:ok, user}
                else
                    {:error, "Invalid Credentials 00200"}
                end
        end

    end 
end