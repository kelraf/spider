defmodule Spider.Vehicles.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spider.Accounts.User
  alias Spider.Businesses.Business


  schema "vehicles" do
    field :registration_number, :string
    field :type, :string

    belongs_to(:user, User)
    belongs_to(:business, Business)

    timestamps()
  end

  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, [:registration_number, :type, :user_id, :business_id])
    |> validate_required([:registration_number, :type, :user_id, :business_id])
    |> unique_constraint(:registration_number)
  end
end
