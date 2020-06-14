defmodule Spider.DLivestockSlaughterOutputs.DLivestockSlaughterOutput do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.DLivestocks.DLivestock

  schema "d_livestock_slaughter_outputs" do
    field :checked, :boolean, default: false
    field :output_name, :string
    field :units, :string

    belongs_to(:d_livestock, DLivestock)

    timestamps()
  end

  @doc false
  def changeset(d_livestock_slaughter_output, attrs) do
    d_livestock_slaughter_output
    |> cast(attrs, [:output_name, :units, :checked, :d_livestock_id])
    |> validate_required([:output_name, :units, :checked, :d_livestock_id])
  end
end
