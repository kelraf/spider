defmodule Spider.Vehicles.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.VRoles.VRole


  schema "vehicles" do
    field :registration_number, :string
    field :type, :string
    field :status, :string

    belongs_to(:user, User)
    belongs_to(:business, Business) 

    has_many(:vroles, VRole)

    timestamps()
  end

  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, [:registration_number, :status, :type, :user_id, :business_id])
    |> validate_required([:registration_number, :status, :type, :user_id, :business_id])
    |> unique_constraint(:registration_number)
  end
end
