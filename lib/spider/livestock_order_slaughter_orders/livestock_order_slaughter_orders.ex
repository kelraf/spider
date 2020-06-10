defmodule Spider.LivestockOrderSlaughterOrders do
  @moduledoc """
  The LivestockOrderSlaughterOrders context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.LivestockOrderSlaughterOrders.LivestockOrderSlaughterOrder

  @doc """
  Returns the list of livestock_order_slaughter_orders.

  ## Examples

      iex> list_livestock_order_slaughter_orders()
      [%LivestockOrderSlaughterOrder{}, ...]

  """
  def list_livestock_order_slaughter_orders do
    Repo.all(LivestockOrderSlaughterOrder)
  end

  @doc """
  Gets a single livestock_order_slaughter_order.

  Raises `Ecto.NoResultsError` if the Livestock order slaughter order does not exist.

  ## Examples

      iex> get_livestock_order_slaughter_order!(123)
      %LivestockOrderSlaughterOrder{}

      iex> get_livestock_order_slaughter_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_livestock_order_slaughter_order!(id), do: Repo.get!(LivestockOrderSlaughterOrder, id)

  @doc """
  Creates a livestock_order_slaughter_order.

  ## Examples

      iex> create_livestock_order_slaughter_order(%{field: value})
      {:ok, %LivestockOrderSlaughterOrder{}}

      iex> create_livestock_order_slaughter_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_livestock_order_slaughter_order(attrs \\ %{}) do
    %LivestockOrderSlaughterOrder{}
    |> LivestockOrderSlaughterOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a livestock_order_slaughter_order.

  ## Examples

      iex> update_livestock_order_slaughter_order(livestock_order_slaughter_order, %{field: new_value})
      {:ok, %LivestockOrderSlaughterOrder{}}

      iex> update_livestock_order_slaughter_order(livestock_order_slaughter_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_livestock_order_slaughter_order(%LivestockOrderSlaughterOrder{} = livestock_order_slaughter_order, attrs) do
    livestock_order_slaughter_order
    |> LivestockOrderSlaughterOrder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LivestockOrderSlaughterOrder.

  ## Examples

      iex> delete_livestock_order_slaughter_order(livestock_order_slaughter_order)
      {:ok, %LivestockOrderSlaughterOrder{}}

      iex> delete_livestock_order_slaughter_order(livestock_order_slaughter_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_livestock_order_slaughter_order(%LivestockOrderSlaughterOrder{} = livestock_order_slaughter_order) do
    Repo.delete(livestock_order_slaughter_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking livestock_order_slaughter_order changes.

  ## Examples

      iex> change_livestock_order_slaughter_order(livestock_order_slaughter_order)
      %Ecto.Changeset{source: %LivestockOrderSlaughterOrder{}}

  """
  def change_livestock_order_slaughter_order(%LivestockOrderSlaughterOrder{} = livestock_order_slaughter_order) do
    LivestockOrderSlaughterOrder.changeset(livestock_order_slaughter_order, %{})
  end
end
