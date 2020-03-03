defmodule Spider.Auth do

    import Ecto.Query, only: [from: 2]

    alias Spider.Accounts.User
    alias Spider.Repo

    def login(credentials = %{"phone_number" => phone_number, "password" => password}) do
        
        Repo.get_by(User, :phone_number, phone_number)

    end 
end