defmodule Spider.DProduces.DProduce do
  use Ecto.Schema
  import Ecto.Changeset


  schema "dproduces" do
    field :category, :string
    field :reference, :string
    field :units, :string

    timestamps()
  end

  @doc false
  def changeset(d_produce, attrs) do
    d_produce
    |> cast(attrs, [:reference, :category, :units])
    |> validate_required([:reference, :units])
  end
end
