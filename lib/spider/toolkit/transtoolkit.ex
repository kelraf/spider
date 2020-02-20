defmodule Spider.TranstoolKit do

    use Ecto.Schema
    import Ecto.Changeset
    import Ecto.Query, only: [from: 2]

    alias Spider.Repo
    alias Spider.TranstoolUserRels.TranstoolUserRel

    def validate_role(changeset) do
        
        case get_field(changeset, :role) do
            nil -> 
                changeset
            role ->

                if role not in ["meat_transporter", "milk_transporter"] do
                    add_error(changeset, :role, "Invalid Role")
                else 
                    changeset
                end
        end

    end

    defp list_empty(list) do
        case list do
            [] -> true
            [_|_] -> false    
        end
    end

    def validate_allow_only_one_user_transtool_relationship(changeset) do

        case get_field(changeset, :user_id) do
            nil ->
                changeset
            user_id ->
                case get_field(changeset, :transtool_id) do
                    nil ->
                        changeset
                    transtool_id ->
                        query = from(
                                        tr in TranstoolUserRel,
                                        where: tr.user_id == ^user_id and tr.transtool_id == ^transtool_id,
                                        select: tr
                                    )
                        
                        case Repo.all(query) |> list_empty do
                            true ->
                                changeset
                            false -> 
                                add_error(changeset, :user_id, "Already Connected To The Same Vehicle")
                        end
                        # changeset
                end
        end
        
    end
end