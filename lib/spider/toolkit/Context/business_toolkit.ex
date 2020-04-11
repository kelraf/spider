defmodule Spider.BusinessToolKit do

    use Ecto.Schema
    import Ecto.Changeset

    alias Spider.BusinessAssets

    def validate_business_type(changeset) do

        case get_field(changeset, :business_type) do
            nil -> 
                changeset
            business_type ->
                if business_type not in ["supplier", "transport-air", "transport-road", "transport-water", "transport-rail", "farmer", "slaughter_house", "abattoir"] do
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
                if category not in ["sole_proprietor", "group_ranch", "association", "co-oparative"] do
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

    def create_default_asset(business) do

        cond do

            business.business_type == "supplier" -> 
  
              business_asset = %{
                business_id: business.id,
                asset_name: "product"
              }
  
              BusinessAssets.create_business_asset(business_asset)
  
            business.business_type == "farmer" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "livestock"
              }
  
              BusinessAssets.create_business_asset(business_asset)

              business_asset_one = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)
  
            business.business_type == "slaughter_house" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "livestock"
              }
  
              BusinessAssets.create_business_asset(business_asset)

              business_asset_one = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)
  
            business.business_type == "abattoir" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "livestock"
              }
  
              BusinessAssets.create_business_asset(business_asset)
  
              business_asset_one = %{
                business_id: business.id,
                asset_name: "product"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)

              business_asset_two = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_two)
  
            business.business_type == "transport-air" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "plane"
              }
  
              BusinessAssets.create_business_asset(business_asset)
  
            business.business_type == "transport-water" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "vessle"
              }
  
              BusinessAssets.create_business_asset(business_asset)
  
            business.business_type == "transport-rail" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "train"
              }
  
              BusinessAssets.create_business_asset(business_asset)
  
            business.business_type == "transport-road" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "vehicle"
              }
  
              BusinessAssets.create_business_asset(business_asset)
  
          end

    end
    
end