defmodule Spider.DReqs.DReq do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.DRoles.DRole

  schema "dreqs" do
    field :requirement, :string

    belongs_to(:d_role, DRole)
    timestamps()
  end

  @doc false
  def changeset(d_req, attrs) do
    d_req
    |> cast(attrs, [:requirement])
    |> validate_required([:requirement])
  end
end
