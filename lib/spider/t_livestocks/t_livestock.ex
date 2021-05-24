defmodule Spider.TLivestocks.TLivestock do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Livestocks.Livestock


  schema "tlivestocks" do
    field :quantity, :integer

    belongs_to(:livestock ,Livestock)

    timestamps()
  end

  @doc false
  def changeset(t_livestock, attrs) do
    t_livestock
    |> cast(attrs, [:quantity, :livestock_id])
    |> validate_required([:quantity, :livestock_id])
  end
end
