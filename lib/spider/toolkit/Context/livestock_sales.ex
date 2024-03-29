defmodule Spider.Context.LivestockSales do

    use Ecto.Schema
    import Ecto.Changeset
    import Ecto.Query, only: [from: 2]

    alias Spider.LivestockOrders.LivestockOrder
    alias Spider.CenterOrders.CenterOrder
    alias Spider.LivestockSales.LivestockSale
    alias Spider.Livestocks.Livestock
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
                    case get_field(changeset, :d_livestock_id) do
                        nil ->
                            changeset
                        d_livestock_id ->

                            query = from(
                                l in LivestockOrder,
                                where: l.livestock_order_container_id == ^livestock_order_container_id and l.d_livestock_id == ^d_livestock_id,
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

    def process_livestock_sale(changeset, "create") do

        IO.inspect "Got Here 1"

        case get_field(changeset, :center_order_id) do
            nil ->
               add_error(changeset, :center_order_id, "Center Order Id Is Required")
            center_order_id ->
                case get_field(changeset, :business_id) do
                    nil ->
                        add_error(changeset, :business_id, "Business Id Is Required")
                    business_id ->

                        query = from(
                            co in CenterOrder,
                            where: co.id == ^center_order_id,
                            left_join: l in Livestock,
                            on: co.d_livestock_id == l.d_livestock_id and l.business_id == ^business_id,
                            left_join: lo in LivestockOrder,
                            on: co.livestock_order_id == lo.id,
                            select: {co, l, lo}
                        )

                        results = Repo.all(query)


                        case results |> SpiderData.list_empty? do

                            false -> 

                                IO.inspect "Got Here 2"

                                results = hd(results)

                                case results do
                                    
                                    {_center_order, nil, _livestock_order} ->

                                        add_error(changeset, :livestock, "Resource Not Found")

                                    {_center_order, _livestock, nil} ->

                                        add_error(changeset, :livestock_order, "Resource Not Found")

                                    {nil, _livestock, _livestock_order} ->

                                        add_error(changeset, :center_order_id, "Resource Not Found")

                                    {center_order, livestock, livestock_order} ->

                                        if center_order.available_animals == center_order.required_animals or center_order.status == "complete" or center_order.status == "offline" do
                                            
                                            add_error(changeset, :completed, "Sorry. Order Full")

                                        else
                                            case get_field(changeset, :quantity) do
                                                nil ->
                                                    if livestock.quantity <= 0 do
                                                        add_error(changeset, :quantity, "Oops!! Your Livestock Stock Level is Zero")
                                                    else 

                                                        available_animals = center_order.available_animals 
                                                        required_animals = center_order.required_animals

                                                        capacity = required_animals - available_animals

                                                        cond do
                                                            capacity >= livestock.quantity ->

                                                                if livestock.price <= 99 do
                                                                    add_error(changeset, :price_per_animal, "Your Price is not reasonable.")
                                                                else 

                                                                    new_center_order_params = 
                                                                    center_order 
                                                                    |> Map.from_struct
                                                                    |> Map.drop([:__meta__])
                                                                    |> Map.put(:available_animals, center_order.available_animals + livestock.quantity)
                                                                    |> Map.put(:total_price_available, center_order.total_price_available + livestock.price * livestock.quantity)
                                                                    |> check_center_order_status() 

                                                                    new_livestock_params = 
                                                                    livestock 
                                                                    |> Map.from_struct
                                                                    |> Map.drop([:__meta__])
                                                                    |> Map.put(:quantity, 0)

                                                                    livestock_item = %{
                                                                        livestock: livestock,
                                                                        new_livestock_params: new_livestock_params
                                                                    }

                                                                    center_order_item = %{
                                                                        center_order: center_order,
                                                                        new_center_order_params: new_center_order_params
                                                                    }

                                                                    changeset
                                                                    |> put_change(:quantity, livestock.quantity)
                                                                    |> put_change(:price_per_animal, livestock.price)
                                                                    |> put_change(:total_price, livestock.price * livestock.quantity)
                                                                    |> put_change(:livestock_id, livestock.id)
                                                                    |> put_change(:d_livestock_id, livestock.d_livestock_id)
                                                                    |> put_change(:center_order_item, center_order_item)
                                                                    |> put_change(:livestock_item, livestock_item)
                                                                end

                                                            capacity < livestock.quantity ->

                                                                if livestock.price <= 99 do
                                                                    add_error(changeset, :price_per_animal, "Your Price is not reasonable.")
                                                                else

                                                                    new_center_order_params = 
                                                                    center_order 
                                                                    |> Map.from_struct
                                                                    |> Map.drop([:__meta__])
                                                                    |> Map.put(:available_animals, center_order.available_animals + capacity)
                                                                    |> Map.put(:total_price_available, center_order.total_price_available + livestock.price * capacity)
                                                                    |> check_center_order_status()                                                                    

                                                                    new_livestock_params = 
                                                                    livestock 
                                                                    |> Map.from_struct
                                                                    |> Map.drop([:__meta__])
                                                                    |> Map.put(:quantity, livestock.quantity - capacity)

                                                                    livestock_item = %{
                                                                        livestock: livestock,
                                                                        new_livestock_params: new_livestock_params
                                                                    }

                                                                    center_order_item = %{
                                                                        center_order: center_order,
                                                                        new_center_order_params: new_center_order_params
                                                                    }

                                                                    changeset
                                                                    |> put_change(:quantity, capacity)
                                                                    |> put_change(:price_per_animal, livestock.price)
                                                                    |> put_change(:total_price, livestock.price * capacity)
                                                                    |> put_change(:livestock_id, livestock.id)
                                                                    |> put_change(:d_livestock_id, livestock.d_livestock_id)
                                                                    |> put_change(:center_order_item, center_order_item)
                                                                    |> put_change(:livestock_item, livestock_item)
                                                                end

                                                        end
                                                        
                                                    end

                                                quantity ->
                                                    if livestock.quantity <= 0 do
                                                        add_error(changeset, :quantity, "Your Livestock Stock Level is Zero")
                                                    else 

                                                        IO.inspect "Got Here 3"

                                                        available_animals = center_order.available_animals 
                                                        required_animals = center_order.required_animals

                                                        capacity = required_animals - available_animals

                                                        if quantity > livestock.quantity do

                                                            add_error(changeset, :quantity, "The quantity Provided exceeds Your Livestock Stock Level.")

                                                        else
                                                            if livestock.price <= 99 do
                                                                add_error(changeset, :price_per_animal, "Your Price is not reasonable.")
                                                            else

                                                                if quantity > capacity do
                                                                    add_error(changeset, :quantity, "You Exceeded Required Animals")
                                                                else
                                                                    new_center_order_params = 
                                                                    center_order 
                                                                    |> Map.from_struct
                                                                    |> Map.drop([:__meta__])
                                                                    |> Map.put(:available_animals, center_order.available_animals + quantity)
                                                                    |> Map.put(:total_price_available, center_order.total_price_available + livestock.price * quantity)
                                                                    |> check_center_order_status()                                                                    

                                                                    new_livestock_params = 
                                                                    livestock 
                                                                    |> Map.from_struct
                                                                    |> Map.drop([:__meta__])
                                                                    |> Map.put(:quantity, livestock.quantity - quantity)

                                                                    livestock_item = %{
                                                                        livestock: livestock,
                                                                        new_livestock_params: new_livestock_params
                                                                    }

                                                                    center_order_item = %{
                                                                        center_order: center_order,
                                                                        new_center_order_params: new_center_order_params
                                                                    }

                                                                    changeset
                                                                    |> put_change(:quantity, quantity)
                                                                    |> put_change(:price_per_animal, livestock.price)
                                                                    |> put_change(:total_price, livestock.price * quantity)
                                                                    |> put_change(:livestock_id, livestock.id)
                                                                    |> put_change(:d_livestock_id, livestock.d_livestock_id)
                                                                    |> put_change(:center_order_item, center_order_item)
                                                                    |> put_change(:livestock_item, livestock_item)
                                                                    |> IO.inspect
                                                                end

                                                            end
                                                        end
                                                        
                                                    end
                                            end
                                        end

                                end
                            true ->
                                add_error(changeset, :center_order_id, "Resource Not Found")
                        end

                end

        end
        
    end

    def cancle_rescue_livestock_sale(changeset, "create") do
        changeset
    end

    def cancle_rescue_livestock_sale(changeset, "update") do

        case get_field(changeset, :current_resource_id) do

            nil -> 
                add_error(changeset, :current_resource_id, "can't be blank")
            current_resource_id -> 
                case get_field(changeset, :center_order_id) do
                    nil ->
                        add_error(changeset, :center_order_id, "can't be blank")
                    center_order_id -> 
                        case get_field(changeset, :business_id) do
                            nil ->
                                add_error(changeset, :business_id, "can't be blank")
                            business_id ->

                                case get_field(changeset, :quantity) do
                                    nil ->
                                        add_error(changeset, :business_id, "can't be blank")
                                    quantity -> 

                                        case get_field(changeset, :accept_cancle) do
                                            nil ->
                                                changeset
                                            accept_cancle ->

                                                if accept_cancle !== true do
                                                    changeset
                                                else 

                                                    query = from(
                                                        co in CenterOrder,
                                                        where: co.id == ^center_order_id,
                                                        left_join: l in Livestock,
                                                        on: co.d_livestock_id == l.d_livestock_id and l.business_id == ^business_id,
                                                        left_join: lo in LivestockOrder,
                                                        on: co.livestock_order_id == lo.id,
                                                        left_join: ls in LivestockSale,
                                                        on: ls.id == ^current_resource_id,
                                                        select: {co, l, lo, ls}
                                                    )

                                                    results = Repo.all(query)

                                                    case results |> SpiderData.list_empty? do

                                                        true ->

                                                            add_error(changeset, :center_order_id, "Resource Not Found")

                                                        false ->

                                                            results = hd(results)

                                                            case results do
                                                                
                                                                {_center_order, nil, _livestock_order, _livestock_sale} ->

                                                                    add_error(changeset, :livestock, "Resource Not Found")

                                                                {_center_order, _livestock, nil, _livestock_sale} ->

                                                                    add_error(changeset, :livestock_order, "Resource Not Found")
                                                                
                                                                {_center_order, _livestock, _livestock_order, nil} ->

                                                                    add_error(changeset, :livestock_sale, "Resource Not Found")

                                                                {center_order, livestock, _livestock_order, livestock_sale} ->

                                                                    case get_field(changeset, :status) do
                                                                        nil ->
                                                                            add_error(changeset, :status, "can't be blank")
                                                                        status ->

                                                                            quantity_added_or_deducted = quantity - livestock_sale.quantity
                
                                                                            available_animals = center_order.available_animals 
                                                                            required_animals = center_order.required_animals
            
                                                                            capacity = required_animals - available_animals

                                                                            cond do

                                                                                quantity == 0 and status == 0 and livestock_sale.status > 0 ->

                                                                                    deducted =
                                                                                    quantity_added_or_deducted
                                                                                    |> Integer.to_string() 
                                                                                    |> String.replace_leading("-", "") 
                                                                                    |> Integer.parse()
                                                                                    |> elem(0)
        
                                                                                    new_center_order_params = 
                                                                                    center_order 
                                                                                    |> Map.from_struct
                                                                                    |> Map.drop([:__meta__])
                                                                                    |> Map.put(:available_animals, center_order.available_animals + quantity_added_or_deducted)
                                                                                    |> Map.put(:total_price_available, center_order.total_price_available + livestock.price * quantity_added_or_deducted)
                                                                                    |> check_center_order_status()                                                                    
        
                                                                                    new_livestock_params = 
                                                                                    livestock 
                                                                                    |> Map.from_struct
                                                                                    |> Map.drop([:__meta__])
                                                                                    |> Map.put(:quantity, livestock.quantity + deducted)
        
                                                                                    livestock_item = %{
                                                                                        livestock: livestock,
                                                                                        new_livestock_params: new_livestock_params
                                                                                    }
        
                                                                                    center_order_item = %{
                                                                                        center_order: center_order,
                                                                                        new_center_order_params: new_center_order_params
                                                                                    }
        
                                                                                    changeset
                                                                                    |> put_change(:quantity, deducted)
                                                                                    |> put_change(:center_order_item, center_order_item)
                                                                                    |> put_change(:livestock_item, livestock_item)

                                                                                status >= 1 and livestock_sale.status == 0 ->

                                                                                    if capacity >= quantity do

                                                                                        cond do

                                                                                            quantity > livestock.quantity ->

                                                                                                add_error(changeset, :quantity, "Livestock Stock Level Is Too Low For These Request")

                                                                                            livestock.price <= 99 ->

                                                                                                add_error(changeset, :price_per_animal, "is not reasonable.")

                                                                                            quantity <= 0 ->

                                                                                                add_error(changeset, :quantity, "Quantity Is Not Valid")

                                                                                            true ->

                                                                                                deducted =
                                                                                                quantity_added_or_deducted
                                                                                                |> Integer.to_string() 
                                                                                                |> String.replace_leading("-", "") 
                                                                                                |> Integer.parse()
                                                                                                |> elem(0)
                    
                                                                                                new_center_order_params = 
                                                                                                center_order 
                                                                                                |> Map.from_struct
                                                                                                |> Map.drop([:__meta__])
                                                                                                |> Map.put(:available_animals, center_order.available_animals + quantity)
                                                                                                |> Map.put(:total_price_available, center_order.total_price_available + livestock.price * quantity)
                                                                                                |> check_center_order_status()                                                                    
                    
                                                                                                new_livestock_params = 
                                                                                                livestock 
                                                                                                |> Map.from_struct
                                                                                                |> Map.drop([:__meta__])
                                                                                                |> Map.put(:quantity, livestock.quantity - quantity)
                    
                                                                                                livestock_item = %{
                                                                                                    livestock: livestock,
                                                                                                    new_livestock_params: new_livestock_params
                                                                                                }

                                                                                                center_order_item = %{
                                                                                                    center_order: center_order,
                                                                                                    new_center_order_params: new_center_order_params
                                                                                                }
                    
                                                                                                changeset
                                                                                                |> put_change(:quantity, quantity)
                                                                                                |> put_change(:price_per_animal, livestock.price * quantity)
                                                                                                |> put_change(:center_order_item, center_order_item)
                                                                                                |> put_change(:livestock_item, livestock_item)

                                                                                        end

                                                                                    else 
        
                                                                                        add_error(changeset, :quantity, "Capacity Can't be exceeded.")

                                                                                    end

                                                                            end

                                                                    end 

                                                            end

                                                    end

                                                end
                                        end

                                end

                        end
                end

        end

    end

    def process_livestock_sale(changeset, "update") do

        if get_field(changeset, :accept_cancle) == true do
            changeset
        else

            if get_field(changeset, :status) == 0 do

                add_error(changeset, :status, "Not Allowed")

            else 

                case get_field(changeset, :current_resource_id) do
        
                    nil ->
                        add_error(changeset, :current_resource_id, "can't be blank")
                    current_resource_id ->
                        case get_field(changeset, :center_order_id) do
                            nil ->
                                add_error(changeset, :center_order_id, "can't be blank")
                            center_order_id ->
                                case get_field(changeset, :business_id) do
                                    nil ->
                                        changeset
                                    business_id ->
        
                                        query = from(
                                            co in CenterOrder,
                                            where: co.id == ^center_order_id,
                                            left_join: l in Livestock,
                                            on: co.d_livestock_id == l.d_livestock_id and l.business_id == ^business_id,
                                            left_join: lo in LivestockOrder,
                                            on: co.livestock_order_id == lo.id,
                                            left_join: ls in LivestockSale,
                                            on: ls.id == ^current_resource_id,
                                            select: {co, l, lo, ls}
                                        )
        
                                        results = Repo.all(query)
        
                                        case results |> SpiderData.list_empty? do
        
                                            false -> 
        
                                                results = hd(results)
        
                                                case results do
                                                    
                                                    {_center_order, nil, _livestock_order, _livestock_sale} ->
        
                                                        add_error(changeset, :livestock, "Resource Not Found")
        
                                                    {_center_order, _livestock, nil, _livestock_sale} ->
        
                                                        add_error(changeset, :livestock_order, "Resource Not Found")
                                                    
                                                    {_center_order, _livestock, _livestock_order, nil} ->
        
                                                        add_error(changeset, :livestock_sale, "Resource Not Found")
        
                                                    {center_order, livestock, livestock_order, livestock_sale} ->
        
                                                        status = get_field(changeset, :status)
        
                                                        case get_field(changeset, :quantity) do
        
                                                            nil ->
                                                                add_error(changeset, :quantity, "can't be blank")
                                                            quantity ->
        
                                                                if center_order.available_animals == center_order.required_animals and center_order.status == "complete" and (center_order.available_animals - livestock_sale.quantity) + quantity > center_order.required_animals do
                                                                    add_error(changeset, :completed, "Sorry. Order Full")
                                                                else
                                                                    case get_field(changeset, :quantity) do
                                                                        nil ->
                                                                            add_error(changeset, :quantity, "can't be blank")
                                                                        quantity ->
                                                                            if livestock.quantity <= 0 do
                                                                                add_error(changeset, :quantity, "This Livestock Quantity is Zero")
                                                                            else 
                
                                                                                quantity_added_or_deducted = quantity - livestock_sale.quantity
                
                                                                                available_animals = center_order.available_animals 
                                                                                required_animals = center_order.required_animals
                
                                                                                capacity = required_animals - available_animals
                
                                                                                if quantity > livestock.quantity do
                                                                                    add_error(changeset, :quantity, "The Quantity Provided Exceeds Your Livestock Number.")
                                                                                else
                                                                                    if livestock.price <= 99 do
                                                                                        add_error(changeset, :price_per_animal, "is not reasonable.")
                                                                                    else
                
                                                                                        if quantity_added_or_deducted < 0 do
        
                                                                                            if quantity < 1 do
                                                                                                add_error(changeset, :quantity, "Quantity Can't Be Zero Or Less")
                                                                                            else
            
                                                                                                deducted =
                                                                                                quantity_added_or_deducted
                                                                                                |> Integer.to_string() 
                                                                                                |> String.replace_leading("-", "") 
                                                                                                |> Integer.parse()
                                                                                                |> elem(0)
                    
                                                                                                new_center_order_params = 
                                                                                                center_order 
                                                                                                |> Map.from_struct
                                                                                                |> Map.drop([:__meta__])
                                                                                                |> Map.put(:available_animals, center_order.available_animals + quantity_added_or_deducted)
                                                                                                |> Map.put(:total_price_available, center_order.total_price_available + livestock.price * quantity_added_or_deducted)
                                                                                                |> check_center_order_status()                                                                    
                    
                                                                                                new_livestock_params = 
                                                                                                livestock 
                                                                                                |> Map.from_struct
                                                                                                |> Map.drop([:__meta__])
                                                                                                |> Map.put(:quantity, livestock.quantity + deducted)
                    
                                                                                                livestock_item = %{
                                                                                                    livestock: livestock,
                                                                                                    new_livestock_params: new_livestock_params
                                                                                                }
                    
                                                                                                center_order_item = %{
                                                                                                    center_order: center_order,
                                                                                                    new_center_order_params: new_center_order_params
                                                                                                }
                    
                                                                                                changeset
                                                                                                |> put_change(:quantity, quantity)
                                                                                                |> put_change(:price_per_animal, livestock.price)
                                                                                                |> put_change(:total_price, livestock.price * quantity)
                                                                                                |> put_change(:livestock_id, livestock.id)
                                                                                                |> put_change(:d_livestock_id, livestock.d_livestock_id)
                                                                                                |> put_change(:center_order_item, center_order_item)
                                                                                                |> put_change(:livestock_item, livestock_item)
        
                                                                                            end
                
                                                                                        else
                
                                                                                            if capacity >= quantity_added_or_deducted do
        
                                                                                                new_center_order_params = 
                                                                                                center_order 
                                                                                                |> Map.from_struct
                                                                                                |> Map.drop([:__meta__])
                                                                                                |> Map.put(:available_animals, center_order.available_animals + quantity_added_or_deducted)
                                                                                                |> Map.put(:total_price_available, center_order.total_price_available + livestock.price * quantity_added_or_deducted)
                                                                                                |> check_center_order_status()                                                                    
                
                                                                                                new_livestock_params = 
                                                                                                livestock 
                                                                                                |> Map.from_struct
                                                                                                |> Map.drop([:__meta__])
                                                                                                |> Map.put(:quantity, livestock.quantity - quantity_added_or_deducted)
                
                                                                                                livestock_item = %{
                                                                                                    livestock: livestock,
                                                                                                    new_livestock_params: new_livestock_params
                                                                                                }
                
                                                                                                center_order_item = %{
                                                                                                    center_order: center_order,
                                                                                                    new_center_order_params: new_center_order_params
                                                                                                }
                
                                                                                                changeset
                                                                                                |> put_change(:quantity, quantity)
                                                                                                |> put_change(:price_per_animal, livestock.price)
                                                                                                |> put_change(:total_price, livestock.price * quantity)
                                                                                                |> put_change(:livestock_id, livestock.id)
                                                                                                |> put_change(:d_livestock_id, livestock.d_livestock_id)
                                                                                                |> put_change(:center_order_item, center_order_item)
                                                                                                |> put_change(:livestock_item, livestock_item)
        
                                                                                                
        
                                                                                            else
                                                                                                add_error(changeset, :quantity, "Capacity Exceeded")
                                                                                            end
                
                                                                                        end
                                                                                        
                                                                                    end
                                                                                end
                                                                                
                                                                            end
                                                                    end
                                                                end
        
                                                        end
        
                                                        
        
                                                end
                                            true ->
                                                add_error(changeset, :center_order_id, "Resource Not Found center_order")
                                        end
        
                                end
        
                        end
        
                end

                # End Of Block


            end


        end

        
    end

    defp check_center_order_status(center_order) do
        if center_order.available_animals < center_order.required_animals do
            Map.put(center_order, :status, "online")
        else
            if center_order.available_animals == center_order.required_animals do
                Map.put(center_order, :status, "complete")
            else 
                center_order
            end
        end
    end

end