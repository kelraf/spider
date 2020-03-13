defmodule Spider.Flights.Flight do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business

  schema "flights" do
    field :role, :string
    field :unique_number, :string

    belongs_to(:user, User)
    belongs_to(:business, Business)
 
    timestamps()
  end

  @doc false
  def changeset(flight, attrs) do
    flight
    |> cast(attrs, [:unique_number, :role, :user_id, :business_id])
    |> validate_required([:unique_number, :role, :user_id, :business_id])
    |> unique_constraint(:unique_number)
  end
end
