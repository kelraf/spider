defmodule SpiderWeb.VerificationController do
    use SpiderWeb, :controller

    alias Spider.UserToolKit
    alias Spider.Sms
    alias Spider.VerificationAgentToolKit

    def sms_sender(conn, %{"user" => user_params}) do

        case UserToolKit.get_user_by_phone user_params do
            {:ok, _} ->
                conn
                |> json(%{
                    message: "Phone number already Taken"
                })
            {:error, _} ->
                # Generate a random code and Send it in an sms
                code = Enum.random(2000..99999)

                # if sms sent successfully spawn a process that will
                # 1. Store the generated random code
                # 2. Wait for code verification
                # 3. Start a countdown
                conn 
                |> json(%{
                    message: "We send an sms with verification Code to #{user_params["phone_number"]}. Please Respond With The Code Sent."
                })
        end

    end

    def verifie_code(conn, %{"user" => user_params}) do
        # This action will receive verification Code
        # Spawn a process that will send the code to the process spawn earler for verification
    end
end