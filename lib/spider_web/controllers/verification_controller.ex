defmodule SpiderWeb.VerificationController do
    use SpiderWeb, :controller

    alias Spider.UserToolKit
    alias Spider.Sms
    alias Spider.VerificationAgentToolKit
    alias Spider.Accounts
    alias Spider.Accounts.User

    def sms_sender(conn, %{"user" => user_params}) do

        case user_params |> UserToolKit.get_user_by_phone false  do
            {:ok, _} ->
                conn
                |> json(%{
                    message: "Phone number already Taken"
                })
            {:error, _} ->
                # Generate a random code and Send it in an sms
                code = Enum.random(1000..9999)
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

    def verify_code(conn, %{"id" => id, "user" => user_params}) do

        user = Accounts.get_user!(id)

        phone_number = user.phone_number

        code = user_params["code"]

        case VerificationAgentToolKit |> VerificationAgentToolKit.get phone_number do

            nil ->
                 
                code = Enum.random(1000..9999)

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

                conn
                |> put_status(:not_found)
                |> json(%{
                    errors: %{
                        error: "Code Expired. Please Try Again"
                    }
                })

            verification_details ->

                case %{"phone_number" => phone_number} |> UserToolKit.get_user_by_phone false  do
                    {:error, message} ->

                        conn
                        |> put_status(:not_found)
                        |> json(%{
                            errors: %{
                                error: message
                            }
                        })

                    {:ok, user} ->

                        if verification_details.code == user_params["code"] do

                            user = Accounts.get_user!(user.id)

                            user_data =  %{
                                "status" => 1,
                                "phone_number" => user.phone_number,
                                "password_hash" => user.password_hash,
                                "first_name" => user.first_name,
                                "last_name" => user.last_name,
                                "pin" => user.pin
                            }

                            with {:ok, %User{} = user} <- Accounts.update_user(user, user_data) do
                                conn
                                |> put_status(:ok)
                                |> json(%{
                                    message: "Successfully Verified Account"
                                })
                            end

                        else
                            conn
                            |> put_status(:bad_request)
                            |> json(%{
                                errors: %{
                                    error: "Invalid Code"
                                }
                            })
                        end
                end

        end
        

    end

end