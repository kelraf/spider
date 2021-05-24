defmodule Spider.DProduces.DProduce do
  use Ecto.Schema
  import Ecto.Changeset


  schema "dproduces" do
    field :referenced_animal, :string
    field :produce_name, :string
    field :units, :string

    timestamps()
  end

  @doc false
  def changeset(d_produce, attrs) do
    d_produce
    |> cast(attrs, [:referenced_animal, :produce_name, :units])
    |> validate_required([:referenced_animal, :produce_name, :units])
  end
end
