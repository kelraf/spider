defmodule Spider.Avatars.Avatar do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Spider.Accounts.User
  alias Spider.Avatars.Avatar
  alias Spider.Helpers.SpiderData
  alias Spider.Repo

  schema "avatars" do

    field :avatar, Spider.Avatar.Type
    field :uuid, :string

    belongs_to(:user, User)
    timestamps()
  end

  @doc false
  def changeset(avatar, attrs, action \\ "create") do
    avatar
    |> cast(attrs, [:user_id, :uuid])
    |> populate_uuid
    |> cast_attachments(attrs, [:avatar])
    |> validate_required([:avatar, :user_id, :uuid])
    |> validate_one_user_with_one_image(action)
    |> create_image_name
  end

  defp populate_uuid(changeset) do
    put_change(changeset, :uuid, Ecto.UUID.generate)
  end

  defp validate_one_user_with_one_image(changeset, action) do

    if action == "update" do
      changeset
    else
      case get_field(changeset, :user_id) do
        nil ->
            changeset
        user_id ->
            query = from(
                a in Avatar,
                where: a.user_id == ^user_id,
                select: a
            )

            case Repo.all(query) |> SpiderData.list_empty? do

                false -> 
                  add_error(changeset, :user_id, "Oparation Impossible. Please Just Update")
                true ->
                  changeset
            end
      end
    end

  end

  defp create_image_name(changeset) do
    
    case get_field(changeset, :user_id) do
      nil ->
        changeset
      user_id ->
        case get_field(changeset, :avatar) do
          nil -> 
            changeset
          avatar -> 
            case get_field(changeset, :uuid) do
              nil -> 
                changeset
              uuid ->
                new_avatar = Map.put(avatar, :file_name, "spider_#{uuid}_#{user_id}#{Path.extname(avatar.file_name)}")
                put_change(changeset, :avatar, new_avatar)
            end
        end
    end
  end 
  
end
