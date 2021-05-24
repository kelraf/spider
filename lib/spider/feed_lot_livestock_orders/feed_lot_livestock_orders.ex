defmodule Spider.FeedLotLivestockOrders do
  @moduledoc """
  The FeedLotLivestockOrders context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.FeedLotLivestockOrders.FeedLotLivestockOrder

  @doc """
  Returns the list of feed_lot_livestock_orders.

  ## Examples

      iex> list_feed_lot_livestock_orders()
      [%FeedLotLivestockOrder{}, ...]

  """
  def list_feed_lot_livestock_orders do
    Repo.all(FeedLotLivestockOrder)
  end

  @doc """
  Gets a single feed_lot_livestock_order.

  Raises `Ecto.NoResultsError` if the Feed lot livestock order does not exist.

  ## Examples

      iex> get_feed_lot_livestock_order!(123)
      %FeedLotLivestockOrder{}

      iex> get_feed_lot_livestock_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_feed_lot_livestock_order!(id), do: Repo.get!(FeedLotLivestockOrder, id)

  @doc """
  Creates a feed_lot_livestock_order.

  ## Examples

      iex> create_feed_lot_livestock_order(%{field: value})
      {:ok, %FeedLotLivestockOrder{}}

      iex> create_feed_lot_livestock_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_feed_lot_livestock_order(attrs \\ %{}) do
    %FeedLotLivestockOrder{}
    |> FeedLotLivestockOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a feed_lot_livestock_order.

  ## Examples

      iex> update_feed_lot_livestock_order(feed_lot_livestock_order, %{field: new_value})
      {:ok, %FeedLotLivestockOrder{}}

      iex> update_feed_lot_livestock_order(feed_lot_livestock_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_feed_lot_livestock_order(%FeedLotLivestockOrder{} = feed_lot_livestock_order, attrs) do
    feed_lot_livestock_order
    |> FeedLotLivestockOrder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FeedLotLivestockOrder.

  ## Examples

      iex> delete_feed_lot_livestock_order(feed_lot_livestock_order)
      {:ok, %FeedLotLivestockOrder{}}

      iex> delete_feed_lot_livestock_order(feed_lot_livestock_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_feed_lot_livestock_order(%FeedLotLivestockOrder{} = feed_lot_livestock_order) do
    Repo.delete(feed_lot_livestock_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking feed_lot_livestock_order changes.

  ## Examples

      iex> change_feed_lot_livestock_order(feed_lot_livestock_order)
      %Ecto.Changeset{source: %FeedLotLivestockOrder{}}

  """
  def change_feed_lot_livestock_order(%FeedLotLivestockOrder{} = feed_lot_livestock_order) do
    FeedLotLivestockOrder.changeset(feed_lot_livestock_order, %{})
  end
end
