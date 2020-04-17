defmodule Spider.Groups do
  @moduledoc """
  The Groups context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.Groups.Group
  alias  Spider.TranstoolKit
  alias Spider.Helpers.SpiderData

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups do
    Repo.all(Group)
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

  def get_group(business_id) do

    query = from g in Group,
                where: g.business_id == ^business_id,
                select: g

    group = Repo.all query

    case group |> TranstoolKit.list_empty do

      true ->

        {:empty, "Empty"}

      false ->

        group = group |> Repo.preload(:user) |> Repo.preload(:business)

        users = Enum.map(group, fn g ->

          %{
            first_name: g.user.first_name,
            last_name: g.user.last_name,
            phone_number: g.user.phone_number,
            user_id: g.user.id
          }

        end)

        case group |> SpiderData.list_head do

          {:empty} ->
            {:empty, "Empty"}

          {:ok, group_user} ->
              
            group = %{
              id: group_user.id,
              business_name: group_user.business.business_name,
              business_id: group_user.business.id,
              members: users
            }
    
            {:ok, group}

        end

        
    end

  end

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs, "update")
    |> Repo.update()
  end

  @doc """
  Deletes a Group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{source: %Group{}}

  """
  def change_group(%Group{} = group) do
    Group.changeset(group, %{})
  end
end
