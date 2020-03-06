defmodule SpiderWeb.VerificationController do
    use SpiderWeb, :controller

    alias Spider.UserToolKit
    alias Spider.Sms
    alias Spider.VerificationAgentToolKit

    def sms_sender(conn, %{"user" => user_params}) do

        case user_params |> UserToolKit.get_user_by_phone false  do
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
                conn
                |> json(%{
                  errors: %{
                    phone_number: ["Invalid Phone Number"]
                  }
                })
        
              byte_size(phone_number) > 15 ->
                conn
                |> json(%{
                  errors: %{
                    phone_number: ["Invalid Phone Number"]
                  }
                })
        
              true ->

                case user_params |> UserToolKit.get_user_by_phone false  do
                    {:error, message} ->
                        conn
                        |> json(%{
                            message: message
                        })
                    {:ok, user} ->
                        conn
                        |> json(%{
                            id: user.id,
                            phone_number: user.phone_number,
                            email: user.email,
                            password_hash: user.password_hash,
                            first_name: user.first_name,
                            last_name: user.last_name,
                            role: user.role,
                            status: user.status,
                            national_id_number: user.national_id_number,
                            pin: user.pin,
                            country_name: user.country_name,
                            country_calling_code: user.country_calling_code,
                            currency: user.currency,
                            currency_name: user.currency_name,
                            continent_code: user.continent_code,
                            latitude: user.latitude,
                            longitude: user.longitude
                        })
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

end