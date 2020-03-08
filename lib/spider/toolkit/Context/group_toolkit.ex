defmodule Spider.Context.GroupToolKit do

    use Ecto.Schema
    import Ecto.Changeset
    import Ecto.Query, only: [from: 2]

    alias Spider.Repo
    alias Spider.Groups.Group
    alias Spider.Businesses.Business
    alias Spider.Helpers.SpiderData

    def validate_one_for_one_user_group_relationship(changeset, action) do

        case get_field(changeset, :user_id) do
            nil ->
                changeset
            user_id ->
                case get_field(changeset, :business_id) do
                    nil ->
                        changeset 
                    business_id ->
                        
                        if action == "update" do
                            changeset
                        else

                            query = from(
                                g in Group,
                                where: g.user_id == ^user_id and g.business_id == ^business_id,
                                select: g
                            )
    
                            case Repo.all(query) |> SpiderData.list_empty? do
    
                                false -> 
                                    add_error(changeset, :user_id, "Already In The Group")
    
                                true ->
                                    changeset
    
                            end
                            
                        end

                end
        end

    end

    def validate_restrict_join_non_group_business(changeset) do

        case get_field(changeset, :business_id) do
            nil ->
                changeset
            business_id ->

                query = from(
                    b in Business,
                    where: b.id == ^business_id,
                    select: b
                )

                case Repo.all(query) |> SpiderData.list_head do

                    {:empty} ->
                        add_error(changeset, :business_id, "These Business is not Recognised")

                    {:ok, business} ->

                        if business.category not in ["group_ranch", "association", "co-oparative"] do
                            add_error(changeset, :business_id, "Sorry You Cannot join That Business")
                        else 
                            changeset
                        end

                end
        end

    end

end