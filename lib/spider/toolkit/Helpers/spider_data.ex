defmodule Spider.Helpers.SpiderData do
    def list_empty?(list) do
        case list do
            [] -> true
            [_|_] -> false
        end
    end
end