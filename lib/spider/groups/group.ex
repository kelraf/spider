defmodule Spider.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.Accounts.User
  alias Spider.Businesses.Business
  alias Spider.Context.GroupToolKit

  schema "groups" do

    field :status, :boolean, default: false

    belongs_to(:user, User)
    belongs_to(:business, Business)

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:user_id, :business_id, :status])
    |> validate_required([:user_id, :business_id, :status])
    |> GroupToolKit.validate_restrict_join_non_group_business()
    |> GroupToolKit.validate_one_for_one_user_group_relationship()
  end
end
