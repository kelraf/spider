defmodule Spider.TRoles.TRole do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Trains.Train
  alias Spider.DRoles.DRole

  schema "troles" do
    field :capacity, :integer 

    belongs_to(:drole, DRole)
    belongs_to(:train, Train)

    timestamps()
  end

  @doc false
  def changeset(t_role, attrs) do
    t_role
    |> cast(attrs, [:capacity, :drole_id, :train_id])
    |> validate_required([:capacity, :drole_id, :train_id])
  end
end
