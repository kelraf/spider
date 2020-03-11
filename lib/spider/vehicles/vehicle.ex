defmodule Spider.Vehicles.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset


  schema "vehicles" do
    field :registration_number, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, [:registration_number, :role])
    |> validate_required([:registration_number, :role])
    |> unique_constraint(:registration_number)
  end
end
