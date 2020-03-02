defmodule Spider.BusinessesTest do
  use Spider.DataCase

  alias Spider.Businesses

  describe "businesses" do
    alias Spider.Businesses.Business

    @valid_attrs %{business_name: "some business_name", country_code: "some country_code", county: "some county", kra_pin: "some kra_pin", location: "some location", registration_number: "some registration_number", sub_county: "some sub_county", ward: "some ward"}
    @update_attrs %{business_name: "some updated business_name", country_code: "some updated country_code", county: "some updated county", kra_pin: "some updated kra_pin", location: "some updated location", registration_number: "some updated registration_number", sub_county: "some updated sub_county", ward: "some updated ward"}
    @invalid_attrs %{business_name: nil, country_code: nil, county: nil, kra_pin: nil, location: nil, registration_number: nil, sub_county: nil, ward: nil}

    def business_fixture(attrs \\ %{}) do
      {:ok, business} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Businesses.create_business()

      business
    end

    test "list_businesses/0 returns all businesses" do
      business = business_fixture()
      assert Businesses.list_businesses() == [business]
    end

    test "get_business!/1 returns the business with given id" do
      business = business_fixture()
      assert Businesses.get_business!(business.id) == business
    end

    test "create_business/1 with valid data creates a business" do
      assert {:ok, %Business{} = business} = Businesses.create_business(@valid_attrs)
      assert business.business_name == "some business_name"
      assert business.country_code == "some country_code"
      assert business.county == "some county"
      assert business.kra_pin == "some kra_pin"
      assert business.location == "some location"
      assert business.registration_number == "some registration_number"
      assert business.sub_county == "some sub_county"
      assert business.ward == "some ward"
    end

    test "create_business/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Businesses.create_business(@invalid_attrs)
    end

    test "update_business/2 with valid data updates the business" do
      business = business_fixture()
      assert {:ok, business} = Businesses.update_business(business, @update_attrs)
      assert %Business{} = business
      assert business.business_name == "some updated business_name"
      assert business.country_code == "some updated country_code"
      assert business.county == "some updated county"
      assert business.kra_pin == "some updated kra_pin"
      assert business.location == "some updated location"
      assert business.registration_number == "some updated registration_number"
      assert business.sub_county == "some updated sub_county"
      assert business.ward == "some updated ward"
    end

    test "update_business/2 with invalid data returns error changeset" do
      business = business_fixture()
      assert {:error, %Ecto.Changeset{}} = Businesses.update_business(business, @invalid_attrs)
      assert business == Businesses.get_business!(business.id)
    end

    test "delete_business/1 deletes the business" do
      business = business_fixture()
      assert {:ok, %Business{}} = Businesses.delete_business(business)
      assert_raise Ecto.NoResultsError, fn -> Businesses.get_business!(business.id) end
    end

    test "change_business/1 returns a business changeset" do
      business = business_fixture()
      assert %Ecto.Changeset{} = Businesses.change_business(business)
    end
  end
end
