defmodule Spider.Helpers.SpiderData do

    def list_empty?(list) do
        case list do
            [] -> true
            [_|_] -> false
        end
    end

    def list_head(list) do

        case list |> list_empty? do
            true ->
                {:empty}
            false ->
                {:ok, hd(list)}
        end

    end
end