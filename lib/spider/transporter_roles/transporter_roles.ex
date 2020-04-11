defmodule Spider.TransporterRoles do
  @moduledoc """
  The TransporterRoles context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.TransporterRoles.TransporterRole

  @doc """
  Returns the list of transporterroles.

  ## Examples

      iex> list_transporterroles()
      [%TransporterRole{}, ...]

  """
  def list_transporterroles do
    Repo.all(TransporterRole)
  end

  @doc """
  Gets a single transporter_role.

  Raises `Ecto.NoResultsError` if the Transporter role does not exist.

  ## Examples

      iex> get_transporter_role!(123)
      %TransporterRole{}

      iex> get_transporter_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transporter_role!(id), do: Repo.get!(TransporterRole, id)

  @doc """
  Creates a transporter_role.

  ## Examples

      iex> create_transporter_role(%{field: value})
      {:ok, %TransporterRole{}}

      iex> create_transporter_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transporter_role(attrs \\ %{}) do
    %TransporterRole{}
    |> TransporterRole.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transporter_role.

  ## Examples

      iex> update_transporter_role(transporter_role, %{field: new_value})
      {:ok, %TransporterRole{}}

      iex> update_transporter_role(transporter_role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transporter_role(%TransporterRole{} = transporter_role, attrs) do
    transporter_role
    |> TransporterRole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TransporterRole.

  ## Examples

      iex> delete_transporter_role(transporter_role)
      {:ok, %TransporterRole{}}

      iex> delete_transporter_role(transporter_role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transporter_role(%TransporterRole{} = transporter_role) do
    Repo.delete(transporter_role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transporter_role changes.

  ## Examples

      iex> change_transporter_role(transporter_role)
      %Ecto.Changeset{source: %TransporterRole{}}

  """
  def change_transporter_role(%TransporterRole{} = transporter_role) do
    TransporterRole.changeset(transporter_role, %{})
  end
end
