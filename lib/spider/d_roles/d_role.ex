defmodule Spider.DRoles.DRole do
  use Ecto.Schema
  import Ecto.Changeset


  schema "droles" do

    field :role, :string
    field :capacity_units, :string

    timestamps()
  end

  @doc false
  def changeset(d_role, attrs) do
    d_role
    |> cast(attrs, [:role, :capacity_units])
    |> validate_required([:role, :capacity_units])
  end
end
