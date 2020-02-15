defmodule Spider.TranstoolUserRels.TranstoolUserRel do

  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.Transtools.Transtool


  schema "transtooluserrels" do

    belongs_to(:user, User)
    belongs_to(:business, Business)
    belongs_to(:transtool, Transtool)

    timestamps()
  end

  @doc false
  def changeset(transtool_user_rel, attrs) do
    transtool_user_rel
    |> cast(attrs, [:user_id, :business_id, :transtool_id])
    |> validate_required([:user_id, :business_id, :transtool_id])
  end
end
