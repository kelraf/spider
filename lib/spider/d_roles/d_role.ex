defmodule Spider.DRoles.DRole do
  use Ecto.Schema
  import Ecto.Changeset


  schema "droles" do
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(d_role, attrs) do
    d_role
    |> cast(attrs, [:role])
    |> validate_required([:role])
  end
end
