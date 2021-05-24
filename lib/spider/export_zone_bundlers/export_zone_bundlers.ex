defmodule Spider.ExportZoneBundlers do
  @moduledoc """
  The ExportZoneBundlers context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.ExportZoneBundlers.ExportZoneBundler

  @doc """
  Returns the list of export_zone_bundler.

  ## Examples

      iex> list_export_zone_bundler()
      [%ExportZoneBundler{}, ...]

  """
  def list_export_zone_bundler do
    Repo.all(ExportZoneBundler)
  end

  @doc """
  Gets a single export_zone_bundler.

  Raises `Ecto.NoResultsError` if the Export zone bundler does not exist.

  ## Examples

      iex> get_export_zone_bundler!(123)
      %ExportZoneBundler{}

      iex> get_export_zone_bundler!(456)
      ** (Ecto.NoResultsError)

  """
  def get_export_zone_bundler!(id), do: Repo.get!(ExportZoneBundler, id)

  @doc """
  Creates a export_zone_bundler.

  ## Examples

      iex> create_export_zone_bundler(%{field: value})
      {:ok, %ExportZoneBundler{}}

      iex> create_export_zone_bundler(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_export_zone_bundler(attrs \\ %{}) do
    %ExportZoneBundler{}
    |> ExportZoneBundler.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a export_zone_bundler.

  ## Examples

      iex> update_export_zone_bundler(export_zone_bundler, %{field: new_value})
      {:ok, %ExportZoneBundler{}}

      iex> update_export_zone_bundler(export_zone_bundler, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_export_zone_bundler(%ExportZoneBundler{} = export_zone_bundler, attrs) do
    export_zone_bundler
    |> ExportZoneBundler.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ExportZoneBundler.

  ## Examples

      iex> delete_export_zone_bundler(export_zone_bundler)
      {:ok, %ExportZoneBundler{}}

      iex> delete_export_zone_bundler(export_zone_bundler)
      {:error, %Ecto.Changeset{}}

  """
  def delete_export_zone_bundler(%ExportZoneBundler{} = export_zone_bundler) do
    Repo.delete(export_zone_bundler)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking export_zone_bundler changes.

  ## Examples

      iex> change_export_zone_bundler(export_zone_bundler)
      %Ecto.Changeset{source: %ExportZoneBundler{}}

  """
  def change_export_zone_bundler(%ExportZoneBundler{} = export_zone_bundler) do
    ExportZoneBundler.changeset(export_zone_bundler, %{})
  end
end
