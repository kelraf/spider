defmodule Spider.VRoles.VRole do
  use Ecto.Schema
  import Ecto.Changeset


  schema "vroles" do

    timestamps()
  end

  @doc false
  def changeset(v_role, attrs) do
    v_role
    |> cast(attrs, [])
    |> validate_required([])
  end
end
