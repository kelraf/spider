defmodule Spider.ProcessToolKit do

    def create_process(%{code: code, phone_number: phone_number}) do

        data_store = %{code: code, phone_number: phone_number}

        receive do
            {:response, x} ->
                IO.inspect x 
                case x do
                    ^data_store -> 
                        {:ok, data_store.phone_number}
                    _ -> 
                        {:error, "Invalid Code. Please Try Again"}
                end
            _-> IO.puts("i failed")
        end

    end

    def clean_pid(_pid) do
        {:ok}
    end

    def create_pid(_pid) do
        {:ok}
    end

    def encode_pid(_pid) do
        {:ok}
    end

    def decode_pid(_pid_str) do
        {:ok}
    end

end