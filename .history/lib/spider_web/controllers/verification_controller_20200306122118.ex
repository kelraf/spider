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
                phone_number = user_params["phone_number"]

                spider_code = %{
                    code: code,
                    created: NaiveDateTime.utc_now,
                    status: 1
                }

                VerificationAgentToolKit.put VerificationAgentToolKit, phone_number, spider_code

                Task.start(fn -> 
                    Process.sleep(90000);
                    VerificationAgentToolKit.delete_one VerificationAgentToolKit, phone_number
                end)

                # message = "Hello, You are one step away from joining Amic. #{code} is your verification Code."

                # case Sms.sendSms(phone_number, message) do
                #     {:ok, _response} ->
                        conn 
                        |> json(%{
                            phone_number:  phone_number,
                            message: "We send an sms with verification Code to #{phone_number}. Please Respond With The Code Sent."
                        })
                #     {:error, _error} ->
                #         conn 
                #         |> json(%{
                #             message: "Oops, Something Went Wrong. Please Try Again"
                #         })
                # end
        end

    end

    def verify_code(conn, %{"user" => user_params}) do

        phone_number = user_params["phone_number"]
        code = user_params["code"]

        cond do
            byte_size(phone_number) < 10 ->
        end
        
        conn
        |> json(%{
            message: "Success",
            map: %{
                phone_number: phone_number,
                code: code
            }
        })

    end

end