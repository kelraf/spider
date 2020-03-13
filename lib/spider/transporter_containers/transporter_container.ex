defmodule Spider.TransporterContainers.TransporterContainer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business

  schema "transportercontainer" do
    field :order_id, :integer
    field :status, :integer

    belongs_to(:user, User)
    belongs_to(:business, Business)

    timestamps()
  end

  @doc false
  def changeset(transporter_container, attrs) do
    transporter_container
    |> cast(attrs, [:order_id, :status, :user_id, :business_id])
    |> validate_required([:user_id, :business_id])
  end
end
