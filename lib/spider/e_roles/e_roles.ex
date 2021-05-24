defmodule Spider.ERoles do
  @moduledoc """
  The ERoles context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.ERoles.ERole

  @doc """
  Returns the list of eroles.

  ## Examples

      iex> list_eroles()
      [%ERole{}, ...]

  """
  def list_eroles do
    Repo.all(ERole)
  end

  @doc """
  Gets a single e_role.

  Raises `Ecto.NoResultsError` if the E role does not exist.

  ## Examples

      iex> get_e_role!(123)
      %ERole{}

      iex> get_e_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_e_role!(id), do: Repo.get!(ERole, id)

  @doc """
  Creates a e_role.

  ## Examples

      iex> create_e_role(%{field: value})
      {:ok, %ERole{}}

      iex> create_e_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_e_role(attrs \\ %{}) do
    %ERole{}
    |> ERole.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a e_role.

  ## Examples

      iex> update_e_role(e_role, %{field: new_value})
      {:ok, %ERole{}}

      iex> update_e_role(e_role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_e_role(%ERole{} = e_role, attrs) do
    e_role
    |> ERole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ERole.

  ## Examples

      iex> delete_e_role(e_role)
      {:ok, %ERole{}}

      iex> delete_e_role(e_role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_e_role(%ERole{} = e_role) do
    Repo.delete(e_role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking e_role changes.

  ## Examples

      iex> change_e_role(e_role)
      %Ecto.Changeset{source: %ERole{}}

  """
  def change_e_role(%ERole{} = e_role) do
    ERole.changeset(e_role, %{})
  end
end
