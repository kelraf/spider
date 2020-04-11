defmodule Spider.TransporterRoles.TransporterRole do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Vehicles.Vehicle
  alias Spider.Flights.Flight
  alias Spider.Trains.Train
  alias Spider.AdminTransporterRoles.AdminTransporterRole


  schema "transporterroles" do

    field :status, :string, default: :ok

    belongs_to(:admin_transporter_role, AdminTransporterRole)
    belongs_to(:vehicle, Vehicle)
    belongs_to(:flight, Flight)
    belongs_to(:train, Train)

    timestamps()
  end

  @doc false
  def changeset(transporter_role, attrs) do
    transporter_role
    |> cast(attrs, [:admin_transporter_role_id, :vehicle_id, :flight_id, :train_id])
    |> validate_required([:status])
  end
end
