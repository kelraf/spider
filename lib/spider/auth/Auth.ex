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

                    cond do
                        user.status == 0 ->

                            {:not_verified, "Your Account is not Verified"}

                        user.status == 1 ->

                            user_struct = user

                            user = Map.from_struct(user)
                            
                            user_data_to_encode = %{
                                id: user.id,
                                role: user.role,
                                email: user.email,
                                phone_number: user.phone_number
                            }

                            {:ok, user_data_to_encode, user_struct}
                            
                    end

                else
                    {:error, "Invalid Credentials 00200"}
                end
        end

    end 
end