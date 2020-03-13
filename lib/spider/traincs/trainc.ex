defmodule Spider.Traincs.Trainc do
  use Ecto.Schema
  import Ecto.Changeset


  schema "traincs" do
    field :role, :string
    field :unique_number, :string

    timestamps()
  end

  @doc false
  def changeset(trainc, attrs) do
    trainc
    |> cast(attrs, [:unique_number, :role])
    |> validate_required([:unique_number, :role])
    |> unique_constraint(:unique_number)
  end
end
