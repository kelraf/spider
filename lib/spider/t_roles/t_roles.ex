defmodule Spider.TRoles do
  @moduledoc """
  The TRoles context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.TRoles.TRole

  @doc """
  Returns the list of troles.

  ## Examples

      iex> list_troles()
      [%TRole{}, ...]

  """
  def list_troles do
    Repo.all(TRole)
  end

  @doc """
  Gets a single t_role.

  Raises `Ecto.NoResultsError` if the T role does not exist.

  ## Examples

      iex> get_t_role!(123)
      %TRole{}

      iex> get_t_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_t_role!(id), do: Repo.get!(TRole, id)

  @doc """
  Creates a t_role.

  ## Examples

      iex> create_t_role(%{field: value})
      {:ok, %TRole{}}

      iex> create_t_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_t_role(attrs \\ %{}) do
    %TRole{}
    |> TRole.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a t_role.

  ## Examples

      iex> update_t_role(t_role, %{field: new_value})
      {:ok, %TRole{}}

      iex> update_t_role(t_role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_t_role(%TRole{} = t_role, attrs) do
    t_role
    |> TRole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TRole.

  ## Examples

      iex> delete_t_role(t_role)
      {:ok, %TRole{}}

      iex> delete_t_role(t_role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_t_role(%TRole{} = t_role) do
    Repo.delete(t_role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking t_role changes.

  ## Examples

      iex> change_t_role(t_role)
      %Ecto.Changeset{source: %TRole{}}

  """
  def change_t_role(%TRole{} = t_role) do
    TRole.changeset(t_role, %{})
  end
end
