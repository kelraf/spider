defmodule Spider.Context.ProduceOrders do
    use Ecto.Schema
    import Ecto.Changeset
    import Ecto.Query, only: [from: 2]

    alias Spider.Produces.Produce
    alias Spider.Helpers.SpiderData
    alias Spider.Repo

    def calc_total_cost(changeset) do
        case get_field(changeset, :price_per_unit) do
            nil ->
                changeset
            price_per_unit -> 
                case get_field(changeset, :quantity) do
                    nil ->
                        changeset
                    quantity ->
                        put_change(changeset, :total_cost, price_per_unit * quantity)
                end
        end
    end

end