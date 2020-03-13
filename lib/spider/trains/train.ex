defmodule Spider.Trains.Train do
  use Ecto.Schema
  import Ecto.Changeset


  schema "trains" do
    field :unique_number, :string

    timestamps()
  end

  @doc false
  def changeset(train, attrs) do
    train
    |> cast(attrs, [:unique_number])
    |> validate_required([:unique_number])
    |> unique_constraint(:unique_number)
  end
end
