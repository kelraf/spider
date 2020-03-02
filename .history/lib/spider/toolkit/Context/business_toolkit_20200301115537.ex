defmodule Spider.BusinessToolKit do

    use Ecto.Schema
    import Ecto.Changeset

    def validate_business_type(changeset) do

        case get_field(changeset, :business_type) do
            nil -> 
                changeset
            business_type ->
                if business_type not in ["supplier", "distributor", "farmer", "slaughter_house", "abour"] do
                    add_error(changeset, :business_type, "Unknown Business Type")
                else
                    changeset
                end
        end

    end

    def validate_business_category(changeset) do

        case get_field(changeset, :category) do
            nil -> 
                changeset
            category -> 
                if category not in ["sole_proprietor", "company", "group_ranch", "association", "co-oparative"] do
                    add_error(changeset, :category, "Unknown Business Category")
                else
                    changeset
                end
        end

    end

    def validate_country_code(changeset) do

        case get_field(changeset, :country_code) do
            nil -> 
                changeset
            country_code ->
                if country_code not in ["254"] do
                    add_error(changeset, :country_code, "Country Code Not Allowed")
                else
                    changeset
                end
        end

    end

end