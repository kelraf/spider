defmodule Spider.Flights.Flight do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.Froles.Frole

  schema "flights" do
    field :type, :string
    field :status, :string, default: "available"
    field :unique_number, :string

    belongs_to(:user, User)
    belongs_to(:business, Business)

    has_many(:froles, Frole)
 
    timestamps()
  end

  @doc false
  def changeset(flight, attrs) do
    flight
    |> cast(attrs, [:unique_number, :type, :status, :user_id, :business_id])
    |> validate_required([:unique_number, :type, :status, :user_id, :business_id])
    |> unique_constraint(:unique_number)
  end
end
