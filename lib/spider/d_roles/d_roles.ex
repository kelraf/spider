defmodule Spider.DRoles do
  @moduledoc """
  The DRoles context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.DRoles.DRole

  @doc """
  Returns the list of droles.

  ## Examples

      iex> list_droles()
      [%DRole{}, ...]

  """
  def list_droles do
    Repo.all(DRole)
  end

  @doc """
  Gets a single d_role.

  Raises `Ecto.NoResultsError` if the D role does not exist.

  ## Examples

      iex> get_d_role!(123)
      %DRole{}

      iex> get_d_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_d_role!(id), do: Repo.get!(DRole, id)

  @doc """
  Creates a d_role.

  ## Examples

      iex> create_d_role(%{field: value})
      {:ok, %DRole{}}

      iex> create_d_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_d_role(attrs \\ %{}) do
    %DRole{}
    |> DRole.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a d_role.

  ## Examples

      iex> update_d_role(d_role, %{field: new_value})
      {:ok, %DRole{}}

      iex> update_d_role(d_role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_d_role(%DRole{} = d_role, attrs) do
    d_role
    |> DRole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DRole.

  ## Examples

      iex> delete_d_role(d_role)
      {:ok, %DRole{}}

      iex> delete_d_role(d_role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_d_role(%DRole{} = d_role) do
    Repo.delete(d_role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking d_role changes.

  ## Examples

      iex> change_d_role(d_role)
      %Ecto.Changeset{source: %DRole{}}

  """
  def change_d_role(%DRole{} = d_role) do
    DRole.changeset(d_role, %{})
  end
end
