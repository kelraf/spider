defmodule Spider.Auth do

    import Ecto.Query, only: [from: 2]

    alias Spider.Accounts.User

    def login(credentials = %{"phone_number" => phone_number, "password" => password}) do
        
        query = from(
            User,
            select: 
        )

    end 
end