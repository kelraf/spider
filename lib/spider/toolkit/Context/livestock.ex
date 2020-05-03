defmodule Spider.Context.Livestock do
    use Ecto.Schema
    import Ecto.Changeset
    import Ecto.Query, only: [from: 2]

    alias Spider.Livestocks.Livestock
    alias Spider.Helpers.SpiderData
    alias Spider.Repo

    def validate_one_for_one_business_livestock(changeset, action) do

        case get_field(changeset, :dlivestock_id) do
            nil ->
                changeset
            dlivestock_id ->
                case get_field(changeset, :business_id) do
                    nil ->
                        changeset 
                    business_id ->

                        if action == "update" do
                            changeset
                        else
                            query = from(
                                l in Livestock,
                                where: l.dlivestock_id == ^dlivestock_id and l.business_id == ^business_id,
                                select: l
                            )
    
                            case Repo.all(query) |> SpiderData.list_empty? do
    
                                false -> 
                                    add_error(changeset, :quantity, "Oops!! Resource Already Exists. Please Just Update.")
    
                                true ->
                                    changeset
    
                            end
                        end
                            
                end
        end

    end

    def validate_min_price(changeset) do
        IO.inspect changeset
        case get_field(changeset, :price) do
          nil ->
            changeset
          price ->
            if price >= 200 do
              changeset
            else 
              add_error(changeset, :price, "Price is too low")
            end
        end
      end

end