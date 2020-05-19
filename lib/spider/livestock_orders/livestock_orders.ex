defmodule Spider.LivestockOrders do
  @moduledoc """
  The LivestockOrders context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.LivestockOrders.LivestockOrder

  @doc """
  Returns the list of livestock_orders.

  ## Examples

      iex> list_livestock_orders()
      [%LivestockOrder{}, ...]

  """
  def list_livestock_orders do
    Repo.all(LivestockOrder)
  end

  @doc """
  Gets a single livestock_order.

  Raises `Ecto.NoResultsError` if the Livestock order does not exist.

  ## Examples

      iex> get_livestock_order!(123)
      %LivestockOrder{}

      iex> get_livestock_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_livestock_order!(id), do: Repo.get!(LivestockOrder, id)

  @doc """
  Creates a livestock_order.

  ## Examples

      iex> create_livestock_order(%{field: value})
      {:ok, %LivestockOrder{}}

      iex> create_livestock_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_livestock_order(attrs \\ %{}) do
    %LivestockOrder{}
    |> LivestockOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a livestock_order.

  ## Examples

      iex> update_livestock_order(livestock_order, %{field: new_value})
      {:ok, %LivestockOrder{}}

      iex> update_livestock_order(livestock_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_livestock_order(%LivestockOrder{} = livestock_order, attrs) do
    livestock_order
    |> LivestockOrder.changeset(attrs, "update")
    |> Repo.update()
  end

  @doc """
  Deletes a LivestockOrder.

  ## Examples

      iex> delete_livestock_order(livestock_order)
      {:ok, %LivestockOrder{}}

      iex> delete_livestock_order(livestock_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_livestock_order(%LivestockOrder{} = livestock_order) do
    Repo.delete(livestock_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking livestock_order changes.

  ## Examples

      iex> change_livestock_order(livestock_order)
      %Ecto.Changeset{source: %LivestockOrder{}}

  """
  def change_livestock_order(%LivestockOrder{} = livestock_order) do
    LivestockOrder.changeset(livestock_order, %{})
  end
end
