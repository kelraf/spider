defmodule Spider.Context.Produce do
    use Ecto.Schema
    import Ecto.Changeset
    import Ecto.Query, only: [from: 2]

    alias Spider.Produces.Produce
    alias Spider.Helpers.SpiderData
    alias Spider.Repo

    def validate_one_for_one_business_produce(changeset, action) do

        case get_field(changeset, :dproduce_id) do
            nil ->
                changeset
            dproduce_id ->
                case get_field(changeset, :business_id) do
                    nil ->
                        changeset 
                    business_id ->

                        if action == "update" do
                            changeset
                        else
                            query = from(
                                p in Produce,
                                where: p.dproduce_id == ^dproduce_id and p.business_id == ^business_id,
                                select: p
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

end