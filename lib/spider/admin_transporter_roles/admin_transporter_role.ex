defmodule Spider.AdminTransporterRoles.AdminTransporterRole do
  use Ecto.Schema
  import Ecto.Changeset


  schema "admintransporterroles" do
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(admin_transporter_role, attrs) do
    admin_transporter_role
    |> cast(attrs, [:role])
    |> validate_required([:role])
  end
end
