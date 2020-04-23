defmodule Spider.DLivestocks.DLivestock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "dlivestock" do
    field :breed, :string
    field :category, :string
    field :reference, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(d_livestock, attrs) do
    d_livestock
    |> cast(attrs, [:reference, :type, :breed, :category])
    |> validate_required([:reference, :breed])
  end
end
