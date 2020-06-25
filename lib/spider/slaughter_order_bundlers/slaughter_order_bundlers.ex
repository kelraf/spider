defmodule Spider.SlaughterOrderBundlers do
  @moduledoc """
  The SlaughterOrderBundlers context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.SlaughterOrderBundlers.SlaughterOrderBundler

  @doc """
  Returns the list of slaughter_order_bundlers.

  ## Examples

      iex> list_slaughter_order_bundlers()
      [%SlaughterOrderBundler{}, ...]

  """
  def list_slaughter_order_bundlers do
    Repo.all(SlaughterOrderBundler)
  end

  @doc """
  Gets a single slaughter_order_bundler.

  Raises `Ecto.NoResultsError` if the Slaughter order bundler does not exist.

  ## Examples

      iex> get_slaughter_order_bundler!(123)
      %SlaughterOrderBundler{}

      iex> get_slaughter_order_bundler!(456)
      ** (Ecto.NoResultsError)

  """
  def get_slaughter_order_bundler!(id), do: Repo.get!(SlaughterOrderBundler, id)

  @doc """
  Creates a slaughter_order_bundler.

  ## Examples

      iex> create_slaughter_order_bundler(%{field: value})
      {:ok, %SlaughterOrderBundler{}}

      iex> create_slaughter_order_bundler(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_slaughter_order_bundler(attrs \\ %{}) do
    %SlaughterOrderBundler{}
    |> SlaughterOrderBundler.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a slaughter_order_bundler.

  ## Examples

      iex> update_slaughter_order_bundler(slaughter_order_bundler, %{field: new_value})
      {:ok, %SlaughterOrderBundler{}}

      iex> update_slaughter_order_bundler(slaughter_order_bundler, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_slaughter_order_bundler(%SlaughterOrderBundler{} = slaughter_order_bundler, attrs) do
    slaughter_order_bundler
    |> SlaughterOrderBundler.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SlaughterOrderBundler.

  ## Examples

      iex> delete_slaughter_order_bundler(slaughter_order_bundler)
      {:ok, %SlaughterOrderBundler{}}

      iex> delete_slaughter_order_bundler(slaughter_order_bundler)
      {:error, %Ecto.Changeset{}}

  """
  def delete_slaughter_order_bundler(%SlaughterOrderBundler{} = slaughter_order_bundler) do
    Repo.delete(slaughter_order_bundler)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking slaughter_order_bundler changes.

  ## Examples

      iex> change_slaughter_order_bundler(slaughter_order_bundler)
      %Ecto.Changeset{source: %SlaughterOrderBundler{}}

  """
  def change_slaughter_order_bundler(%SlaughterOrderBundler{} = slaughter_order_bundler) do
    SlaughterOrderBundler.changeset(slaughter_order_bundler, %{})
  end
end
