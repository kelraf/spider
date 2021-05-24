defmodule Spider.Froles.Frole do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.DRoles.DRole
  alias Spider.Flights.Flight

  schema "froles" do
    field :capacity, :integer

    belongs_to(:drole, DRole)
    belongs_to(:flight, Flight)

    timestamps()
  end

  @doc false
  def changeset(frole, attrs) do
    frole
    |> cast(attrs, [:capacity, :drole_id, :flight_id])
    |> validate_required([:capacity, :drole_id, :flight_id])
  end
end
