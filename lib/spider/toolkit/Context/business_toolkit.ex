defmodule Spider.BusinessToolKit do

    use Ecto.Schema
    import Ecto.Changeset

    alias Spider.BusinessAssets
    alias Spider.Toolkit.Constants.Business

    def validate_business_sub_category(changeset) do

      case get_field(changeset, :exception) do
        nil ->
          case get_field(changeset, :sub_category) do
              nil -> 
                  changeset
                sub_category ->
                  if sub_category not in Business.business_sub_categories() do
                      add_error(changeset, :sub_category, "Business Sub Category Is Invalid")
                  else
                      changeset
                  end
          end
        exception -> 
          case get_field(changeset, :sub_category) do
            nil -> 
                changeset
            sub_category ->
              if sub_category !== "super-instance" do
                  add_error(changeset, :sub_category, "Business Sub Category Is Invalid")
              else
                  changeset
              end
          end
        end
        

    end

    def validate_business_category(changeset) do

      case get_field(changeset, :exception) do
        nil ->
          case get_field(changeset, :category) do
            nil -> 
                changeset
            category ->
              if category not in Business.business_categories() do
                  add_error(changeset, :category, "Business Category Is Invalid")
              else
                  changeset
              end
        end
      exception -> 
        case get_field(changeset, :category) do
          nil -> 
              changeset
          category ->
            if category !== "super-instance" do
                add_error(changeset, :category, "Business Sub Category Is Invalid")
            else
                changeset
            end
        end
      end

  end

    def validate_business_type(changeset) do

      case get_field(changeset, :exception) do
        nil ->
          case get_field(changeset, :business_type) do
              nil -> 
                  changeset
              business_type -> 
                if business_type not in ["sole_proprietor", "group_ranch", "association", "co-oparative"] do
                    add_error(changeset, :business_type, "Unknown Business Type")
                else
                  changeset
                end
          end
        exception -> 
          if exception do
            put_change(changeset, :business_type, "super-instance")
          else
            add_error(changeset, :business_type, "Unknown Business Type Exception")
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

            # <<<<---------------------- pasture-and-feeds ----------------->>>>>

            business.sub_category == "pasture-and-feeds" -> 
  
              business_asset = %{
                business_id: business.id,
                asset_name: "products"
              }
  
              BusinessAssets.create_business_asset(business_asset)
              
            # <<<<---------------------- Livestock Farmar ----------------->>>>>

            business.sub_category == "livestock-farmer" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "livestocks"
              }
  
              BusinessAssets.create_business_asset(business_asset)

              business_asset_one = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)

            # <<<<-------- Slaughter House -------->>>>>
  
            business.sub_category == "slaughter-house" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "livestocks"
              }
  
              BusinessAssets.create_business_asset(business_asset)

              business_asset_one = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)

            # <<<<-------- Abattoir -------->>>>>
  
            business.sub_category == "abattoir" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "livestocks"
              }
  
              BusinessAssets.create_business_asset(business_asset)
  
              business_asset_one = %{
                business_id: business.id,
                asset_name: "products"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)

              business_asset_two = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_two)

            # <<<<-------- accesories-and-equipments -------->>>>>
  
            business.sub_category == "accesories-and-equipments" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "products"
              }
  
              BusinessAssets.create_business_asset(business_asset)

            # <<<<-------- vetcare -------->>>>>
  
            business.sub_category == "vetcare" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "vehicles"
              }
  
              BusinessAssets.create_business_asset(business_asset)

            # <<<<-------- agrovet -------->>>>>
  
            business.sub_category == "agrovet" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "products"
              }
  
              BusinessAssets.create_business_asset(business_asset)

            # <<<<-------- value-addition -------->>>>>
  
            business.sub_category == "value-addition" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "products"
              }
  
              BusinessAssets.create_business_asset(business_asset)

              business_asset_one = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)

            # <<<<-------- distributor -------->>>>>
  
            business.sub_category == "distributor" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "products"
              }
  
              BusinessAssets.create_business_asset(business_asset)

              business_asset_one = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)

            # <<<<-------- wholesaler -------->>>>>
  
            business.sub_category == "wholesaler" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "products"
              }
  
              BusinessAssets.create_business_asset(business_asset)

              business_asset_one = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)


            # <<<<-------- retailer -------->>>>>
  
            business.sub_category == "retailer" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "products"
              }
  
              BusinessAssets.create_business_asset(business_asset)

              business_asset_one = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)

            # <<<<-------- logistics-and-freight -------->>>>>
  
            business.sub_category == "logistics-and-freight" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "plane"
              }
  
              BusinessAssets.create_business_asset(business_asset)

              business_asset_one = %{
                business_id: business.id,
                asset_name: "trains"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)

            # <<<<-------- storage-and-warehousing -------->>>>>
  
            business.sub_category == "storage-and-warehousing" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "products"
              }
  
              BusinessAssets.create_business_asset(business_asset)

              business_asset_one = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)

            # <<<<-------- branding-and-packaging -------->>>>>
  
            business.sub_category == "branding-and-packaging" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "products"
              }
  
              BusinessAssets.create_business_asset(business_asset)

              business_asset_one = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)

            # <<<<-------- handling-and-delivary -------->>>>>
  
            business.sub_category == "handling-and-delivary" ->
  
              business_asset = %{
                business_id: business.id,
                asset_name: "products"
              }
  
              BusinessAssets.create_business_asset(business_asset)

              business_asset_one = %{
                business_id: business.id,
                asset_name: "produce"
              }
  
              BusinessAssets.create_business_asset(business_asset_one)

              business_asset_two = %{
                business_id: business.id,
                asset_name: "vehicles"
              }
  
              BusinessAssets.create_business_asset(business_asset_two)
  
          end

    end
    
end