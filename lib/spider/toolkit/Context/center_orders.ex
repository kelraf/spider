defmodule Spider.Context.CenterOrders do
    
    use Ecto.Schema
    import Ecto.Changeset
    import Ecto.Query, only: [from: 2]

    alias Spider.CenterOrders.CenterOrder
    alias Spider.Helpers.SpiderData
    alias Spider.Repo

    def accumilate_total_price(changeset) do
        
        case get_field(changeset, :required_animals) do
            nil ->
                changeset
            required_animals ->
                case get_field(changeset, :price_per_animal) do
                    nil ->
                        changeset
                    price_per_animal ->
                        put_change(changeset, :total_price, required_animals * price_per_animal)
                end
        end

    end

    def validate_one_center_order_for_one_livestock_order(changeset, action) do
        
        case get_field(changeset, :livestock_order_id) do
            nil ->
                changeset
            livestock_order_id ->

                if action == "update" do
                    changeset
                else
                    query = from(
                        c in CenterOrder,
                        where: c.livestock_order_id == ^livestock_order_id,
                        select: c
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

    def validate_center_order_status(changeset) do
        
        case get_field(changeset, :status) do
            nil ->
                changeset
            status ->
                if status not in ["offline", "online", "complete"] do
                    add_error(changeset, :status, "is invalid")
                else
                    changeset
                end
        end

    end

end