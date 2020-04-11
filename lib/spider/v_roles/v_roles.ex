defmodule Spider.VRoles do
  @moduledoc """
  The VRoles context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.VRoles.VRole

  @doc """
  Returns the list of vroles.

  ## Examples

      iex> list_vroles()
      [%VRole{}, ...]

  """
  def list_vroles do
    Repo.all(VRole)
  end

  @doc """
  Gets a single v_role.

  Raises `Ecto.NoResultsError` if the V role does not exist.

  ## Examples

      iex> get_v_role!(123)
      %VRole{}

      iex> get_v_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_v_role!(id), do: Repo.get!(VRole, id)

  @doc """
  Creates a v_role.

  ## Examples

      iex> create_v_role(%{field: value})
      {:ok, %VRole{}}

      iex> create_v_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_v_role(attrs \\ %{}) do
    %VRole{}
    |> VRole.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a v_role.

  ## Examples

      iex> update_v_role(v_role, %{field: new_value})
      {:ok, %VRole{}}

      iex> update_v_role(v_role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_v_role(%VRole{} = v_role, attrs) do
    v_role
    |> VRole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a VRole.

  ## Examples

      iex> delete_v_role(v_role)
      {:ok, %VRole{}}

      iex> delete_v_role(v_role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_v_role(%VRole{} = v_role) do
    Repo.delete(v_role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking v_role changes.

  ## Examples

      iex> change_v_role(v_role)
      %Ecto.Changeset{source: %VRole{}}

  """
  def change_v_role(%VRole{} = v_role) do
    VRole.changeset(v_role, %{})
  end
end
