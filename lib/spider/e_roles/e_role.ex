defmodule Spider.ERoles.ERole do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.DRoles.DRole
  alias Spider.Vessles.Vessle

  schema "eroles" do
    field(:capacity, :integer)

    belongs_to(:drole, DRole)
    belongs_to(:vessle, Vessle)

    timestamps()
  end

  @doc false
  def changeset(e_role, attrs) do
    e_role
    |> cast(attrs, [:capacity, :drole_id, :vessle_id])
    |> validate_required([:capacity, :drole_id, :vessle_id])
  end
end
