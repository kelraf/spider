defmodule Spider.Context.LivestockOrder do

    use Ecto.Schema
    import Ecto.Changeset
    import Ecto.Query, only: [from: 2]

    alias Spider.LivestockOrders.LivestockOrder
    alias Spider.Helpers.SpiderData
    alias Spider.Repo

    def accumilate_total_cost(changeset) do
        case get_field(changeset, :quantity) do
            nil ->
                changeset
            quantity ->
                case get_field(changeset, :price) do
                    nil -> 
                        changeset
                    price ->
                        put_change(changeset, :total_cost, quantity * price)
                end
        end
    end

    def validate_one_animal_type_per_container(changeset, action) do
        if action == "update" do
            changeset
        else
            case get_field(changeset, :livestock_order_container_id) do
                nil ->
                    changeset
                livestock_order_container_id ->
                    case get_field(changeset, :dlivestock_id) do
                        nil ->
                            changeset
                        dlivestock_id ->

                            query = from(
                                l in LivestockOrder,
                                where: l.livestock_order_container_id == ^livestock_order_container_id and l.dlivestock_id == ^dlivestock_id,
                                select: l
                            )
    
                            case Repo.all(query) |> SpiderData.list_empty? do
    
                                false -> 
                                    add_error(changeset, :resource_exists, "Resource Exists. Please Just Update.")
                                true ->
                                    changeset
                            end

                    end
            end
        end
    end

end