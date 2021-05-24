defmodule Spider.CenterOrders do
  @moduledoc """
  The CenterOrders context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.CenterOrders.CenterOrder

  @doc """
  Returns the list of center_orders.

  ## Examples

      iex> list_center_orders()
      [%CenterOrder{}, ...]

  """
  def list_center_orders do
    Repo.all(CenterOrder)
  end

  @doc """
  Gets a single center_order.

  Raises `Ecto.NoResultsError` if the Center order does not exist.

  ## Examples

      iex> get_center_order!(123)
      %CenterOrder{}

      iex> get_center_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_center_order!(id), do: Repo.get!(CenterOrder, id)

  @doc """
  Creates a center_order.

  ## Examples

      iex> create_center_order(%{field: value})
      {:ok, %CenterOrder{}}

      iex> create_center_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_center_order(attrs \\ %{}) do
    %CenterOrder{}
    |> CenterOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a center_order.

  ## Examples

      iex> update_center_order(center_order, %{field: new_value})
      {:ok, %CenterOrder{}}

      iex> update_center_order(center_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_center_order(%CenterOrder{} = center_order, attrs) do
    center_order
    |> CenterOrder.changeset(attrs, "update")
    |> Repo.update()
  end

  @doc """
  Deletes a CenterOrder.

  ## Examples

      iex> delete_center_order(center_order)
      {:ok, %CenterOrder{}}

      iex> delete_center_order(center_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_center_order(%CenterOrder{} = center_order) do
    Repo.delete(center_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking center_order changes.

  ## Examples

      iex> change_center_order(center_order)
      %Ecto.Changeset{source: %CenterOrder{}}

  """
  def change_center_order(%CenterOrder{} = center_order) do
    CenterOrder.changeset(center_order, %{})
  end
end
