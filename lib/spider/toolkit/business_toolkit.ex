defmodule Spider.BusinessToolKit do

    use Ecto.Schema
    import Ecto.Changeset

    def validate_business_type(changeset) do

        case get_field(changeset, :business_type) do
            nil -> 
                changeset
            business_type ->
                if business_type not in ["solo_proprietor", "group_ranch", "association", "co-oparative"] do
                    add_error(changeset, :business_type, "Unknown Business Type")
                else
                    changeset
                end
        end

    end

end