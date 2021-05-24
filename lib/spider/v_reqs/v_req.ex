defmodule Spider.VReqs.VReq do
  use Ecto.Schema
  import Ecto.Changeset

  alias  Spider.DReqs.DReq
  alias Spider.VRoles.VRole

  schema "vreqs" do

    field :available, :boolean, default: false
    
    belongs_to(:d_req, DReq)
    belongs_to(:v_role, VRole)
    timestamps()
  end

  @doc false
  def changeset(v_req, attrs) do
    v_req
    |> cast(attrs, [:available, :d_req_id, :v_role_id])
    |> validate_required([:available, :d_req_id, :v_role_id])
  end
end
