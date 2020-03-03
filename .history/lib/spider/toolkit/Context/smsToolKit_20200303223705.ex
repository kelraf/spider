defmodule Spider.Sms do

    def sendSms(phone, message) do

        token = "MjU6Ojo6NTk6Ojo6Mjo6OjpWMnp1Q1E4MExySHN4cTc3NkF3YTBVSm9kdWJGVGtqYXRSVEl0Q2g3Rk1Ga1h5RjRtXzBsblQ1MDRmRll3a2Jq"
        url = "https://vas.wasiliana.co.ke/api/message/send/sms"
        body = %{message: message, msisdn: phone, sender_id: "Systemdev"}
        headers = ["X-TOKEN": token, "Accept": "Application/json; Charset=utf-8"]

        encoded_body = Poison.encode!(body)
        
        case HTTPoison.post(url, encoded_body, headers) do
            {:ok, response} ->
                {:ok, response}
            {:error, error} ->
                {:error, error}
        end

    end

end