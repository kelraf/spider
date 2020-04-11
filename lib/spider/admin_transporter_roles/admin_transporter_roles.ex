defmodule Spider.AdminTransporterRoles do
  @moduledoc """
  The AdminTransporterRoles context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.AdminTransporterRoles.AdminTransporterRole

  @doc """
  Returns the list of admintransporterroles.

  ## Examples

      iex> list_admintransporterroles()
      [%AdminTransporterRole{}, ...]

  """
  def list_admintransporterroles do
    Repo.all(AdminTransporterRole)
  end

  @doc """
  Gets a single admin_transporter_role.

  Raises `Ecto.NoResultsError` if the Admin transporter role does not exist.

  ## Examples

      iex> get_admin_transporter_role!(123)
      %AdminTransporterRole{}

      iex> get_admin_transporter_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_admin_transporter_role!(id), do: Repo.get!(AdminTransporterRole, id)

  @doc """
  Creates a admin_transporter_role.

  ## Examples

      iex> create_admin_transporter_role(%{field: value})
      {:ok, %AdminTransporterRole{}}

      iex> create_admin_transporter_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_admin_transporter_role(attrs \\ %{}) do
    %AdminTransporterRole{}
    |> AdminTransporterRole.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a admin_transporter_role.

  ## Examples

      iex> update_admin_transporter_role(admin_transporter_role, %{field: new_value})
      {:ok, %AdminTransporterRole{}}

      iex> update_admin_transporter_role(admin_transporter_role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_admin_transporter_role(%AdminTransporterRole{} = admin_transporter_role, attrs) do
    admin_transporter_role
    |> AdminTransporterRole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AdminTransporterRole.

  ## Examples

      iex> delete_admin_transporter_role(admin_transporter_role)
      {:ok, %AdminTransporterRole{}}

      iex> delete_admin_transporter_role(admin_transporter_role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_admin_transporter_role(%AdminTransporterRole{} = admin_transporter_role) do
    Repo.delete(admin_transporter_role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking admin_transporter_role changes.

  ## Examples

      iex> change_admin_transporter_role(admin_transporter_role)
      %Ecto.Changeset{source: %AdminTransporterRole{}}

  """
  def change_admin_transporter_role(%AdminTransporterRole{} = admin_transporter_role) do
    AdminTransporterRole.changeset(admin_transporter_role, %{})
  end
end
