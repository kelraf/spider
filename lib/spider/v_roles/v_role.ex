defmodule Spider.VRoles.VRole do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.DRoles.DRole
  alias Spider.Vehicles.Vehicle

  schema "vroles" do

    field :capacity, :integer

    belongs_to(:drole, DRole)
    belongs_to(:vehicle, Vehicle)

    timestamps()
  end

  @doc false
  def changeset(v_role, attrs) do
    v_role
    |> cast(attrs, [:drole_id, :vehicle_id, :capacity])
    |> validate_required([:drole_id, :vehicle_id, :capacity])
  end
end
