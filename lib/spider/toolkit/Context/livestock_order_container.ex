defmodule Spider.Context.LivestockOrderContainer do

    use Ecto.Schema
    import Ecto.Changeset
    import Ecto.Query, only: [from: 2]

    alias Spider.LivestockOrderContainers.LivestockOrderContainer
    alias Spider.LivestockOrderContainers
    alias Spider.Helpers.SpiderData
    alias Spider.Repo

    def check_uncompleted_order_container(changeset, action) do

        case get_field(changeset, :user_id) do
            nil ->
                changeset
            _user_id ->
                case get_field(changeset, :business_id) do
                    nil ->
                        changeset 
                    business_id ->
                        
                        if action == "update" do
                            changeset
                        else

                            query = from(
                                l in LivestockOrderContainer,
                                where: l.status == 1 or l.status == 2 and l.business_id == ^business_id,
                                select: l
                            )
    
                            case Repo.all(query) |> SpiderData.list_empty? do
                                false -> 
                                    add_error(changeset, :incomplete_order, "This Business Has Uncompleted Order")
                                true ->
                                    changeset
                            end
                            
                        end

                end
        end

    end

    def validate_required_to_add_or_delete(livestock_order, action, diff \\ nil) do

        livestock_order_container_id = livestock_order.livestock_order_container_id
        total_cost = livestock_order.total_cost

        livestock_order_container = LivestockOrderContainers.get_livestock_order_container! livestock_order_container_id
        
        case action do

            "delete" ->

                IO.puts "Action Is Delete, So Deducting"

                livestock_order_container_total_cost = livestock_order_container.total_cost - total_cost
                livestock_order_container_params = Map.put(livestock_order_container, :total_cost, livestock_order_container_total_cost) |> Map.from_struct |> Map.drop([:__meta__])
                LivestockOrderContainers.update_livestock_order_container(livestock_order_container, livestock_order_container_params)

            "update" ->

                cond do

                    diff < 0 ->

                        IO.puts "The Difference is #{diff}, So Deducting"

                        livestock_order_container_total_cost = livestock_order_container.total_cost + diff
                        livestock_order_container_params = Map.put(livestock_order_container, :total_cost, livestock_order_container_total_cost) |> Map.from_struct |> Map.drop([:__meta__])
                        LivestockOrderContainers.update_livestock_order_container(livestock_order_container, livestock_order_container_params)

                    diff > 0 ->

                        IO.puts "The Difference is #{diff}, So Adding"

                        livestock_order_container_total_cost = livestock_order_container.total_cost + diff
                        livestock_order_container_params = Map.put(livestock_order_container, :total_cost, livestock_order_container_total_cost) |> Map.from_struct |> Map.drop([:__meta__])
                        LivestockOrderContainers.update_livestock_order_container(livestock_order_container, livestock_order_container_params)

                    true ->

                        IO.puts "The Difference is #{diff}, So Doing Nothing"

                        # Do Nothing

                end            

            "create" ->

                IO.puts "Action is Create, So Adding"

                livestock_order_container_total_cost = livestock_order_container.total_cost + total_cost
                livestock_order_container_params = Map.put(livestock_order_container, :total_cost, livestock_order_container_total_cost) |> Map.from_struct |> Map.drop([:__meta__])
                LivestockOrderContainers.update_livestock_order_container(livestock_order_container, livestock_order_container_params)

        end

    end

end