defmodule Spider.ExportZoneLivestockOrders do
  @moduledoc """
  The ExportZoneLivestockOrders context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.ExportZoneLivestockOrders.ExportZoneLivestockOrder

  @doc """
  Returns the list of export_zone_livestock_orders.

  ## Examples

      iex> list_export_zone_livestock_orders()
      [%ExportZoneLivestockOrder{}, ...]

  """
  def list_export_zone_livestock_orders do
    Repo.all(ExportZoneLivestockOrder)
  end

  @doc """
  Gets a single export_zone_livestock_order.

  Raises `Ecto.NoResultsError` if the Export zone livestock order does not exist.

  ## Examples

      iex> get_export_zone_livestock_order!(123)
      %ExportZoneLivestockOrder{}

      iex> get_export_zone_livestock_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_export_zone_livestock_order!(id), do: Repo.get!(ExportZoneLivestockOrder, id)

  @doc """
  Creates a export_zone_livestock_order.

  ## Examples

      iex> create_export_zone_livestock_order(%{field: value})
      {:ok, %ExportZoneLivestockOrder{}}

      iex> create_export_zone_livestock_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_export_zone_livestock_order(attrs \\ %{}) do
    %ExportZoneLivestockOrder{}
    |> ExportZoneLivestockOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a export_zone_livestock_order.

  ## Examples

      iex> update_export_zone_livestock_order(export_zone_livestock_order, %{field: new_value})
      {:ok, %ExportZoneLivestockOrder{}}

      iex> update_export_zone_livestock_order(export_zone_livestock_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_export_zone_livestock_order(%ExportZoneLivestockOrder{} = export_zone_livestock_order, attrs) do
    export_zone_livestock_order
    |> ExportZoneLivestockOrder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ExportZoneLivestockOrder.

  ## Examples

      iex> delete_export_zone_livestock_order(export_zone_livestock_order)
      {:ok, %ExportZoneLivestockOrder{}}

      iex> delete_export_zone_livestock_order(export_zone_livestock_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_export_zone_livestock_order(%ExportZoneLivestockOrder{} = export_zone_livestock_order) do
    Repo.delete(export_zone_livestock_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking export_zone_livestock_order changes.

  ## Examples

      iex> change_export_zone_livestock_order(export_zone_livestock_order)
      %Ecto.Changeset{source: %ExportZoneLivestockOrder{}}

  """
  def change_export_zone_livestock_order(%ExportZoneLivestockOrder{} = export_zone_livestock_order) do
    ExportZoneLivestockOrder.changeset(export_zone_livestock_order, %{})
  end
end
