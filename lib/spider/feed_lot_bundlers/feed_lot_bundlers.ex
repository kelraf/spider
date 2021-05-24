defmodule Spider.FeedLotBundlers do
  @moduledoc """
  The FeedLotBundlers context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.FeedLotBundlers.FeedLotBundler

  @doc """
  Returns the list of feed_lot_bundlers.

  ## Examples

      iex> list_feed_lot_bundlers()
      [%FeedLotBundler{}, ...]

  """
  def list_feed_lot_bundlers do
    Repo.all(FeedLotBundler)
  end

  @doc """
  Gets a single feed_lot_bundler.

  Raises `Ecto.NoResultsError` if the Feed lot bundler does not exist.

  ## Examples

      iex> get_feed_lot_bundler!(123)
      %FeedLotBundler{}

      iex> get_feed_lot_bundler!(456)
      ** (Ecto.NoResultsError)

  """
  def get_feed_lot_bundler!(id), do: Repo.get!(FeedLotBundler, id)

  @doc """
  Creates a feed_lot_bundler.

  ## Examples

      iex> create_feed_lot_bundler(%{field: value})
      {:ok, %FeedLotBundler{}}

      iex> create_feed_lot_bundler(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_feed_lot_bundler(attrs \\ %{}) do
    %FeedLotBundler{}
    |> FeedLotBundler.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a feed_lot_bundler.

  ## Examples

      iex> update_feed_lot_bundler(feed_lot_bundler, %{field: new_value})
      {:ok, %FeedLotBundler{}}

      iex> update_feed_lot_bundler(feed_lot_bundler, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_feed_lot_bundler(%FeedLotBundler{} = feed_lot_bundler, attrs) do
    feed_lot_bundler
    |> FeedLotBundler.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FeedLotBundler.

  ## Examples

      iex> delete_feed_lot_bundler(feed_lot_bundler)
      {:ok, %FeedLotBundler{}}

      iex> delete_feed_lot_bundler(feed_lot_bundler)
      {:error, %Ecto.Changeset{}}

  """
  def delete_feed_lot_bundler(%FeedLotBundler{} = feed_lot_bundler) do
    Repo.delete(feed_lot_bundler)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking feed_lot_bundler changes.

  ## Examples

      iex> change_feed_lot_bundler(feed_lot_bundler)
      %Ecto.Changeset{source: %FeedLotBundler{}}

  """
  def change_feed_lot_bundler(%FeedLotBundler{} = feed_lot_bundler) do
    FeedLotBundler.changeset(feed_lot_bundler, %{})
  end
end
