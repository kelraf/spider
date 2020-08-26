defmodule Spider.ProduceCenterOrders do
  @moduledoc """
  The ProduceCenterOrders context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.ProduceCenterOrders.ProduceCenterOrder

  @doc """
  Returns the list of produce_center_orders.

  ## Examples

      iex> list_produce_center_orders()
      [%ProduceCenterOrder{}, ...]

  """
  def list_produce_center_orders do
    Repo.all(ProduceCenterOrder)
  end

  @doc """
  Gets a single produce_center_order.

  Raises `Ecto.NoResultsError` if the Produce center order does not exist.

  ## Examples

      iex> get_produce_center_order!(123)
      %ProduceCenterOrder{}

      iex> get_produce_center_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_produce_center_order!(id), do: Repo.get!(ProduceCenterOrder, id)

  @doc """
  Creates a produce_center_order.

  ## Examples

      iex> create_produce_center_order(%{field: value})
      {:ok, %ProduceCenterOrder{}}

      iex> create_produce_center_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_produce_center_order(attrs \\ %{}) do
    %ProduceCenterOrder{}
    |> ProduceCenterOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a produce_center_order.

  ## Examples

      iex> update_produce_center_order(produce_center_order, %{field: new_value})
      {:ok, %ProduceCenterOrder{}}

      iex> update_produce_center_order(produce_center_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_produce_center_order(%ProduceCenterOrder{} = produce_center_order, attrs) do
    produce_center_order
    |> ProduceCenterOrder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ProduceCenterOrder.

  ## Examples

      iex> delete_produce_center_order(produce_center_order)
      {:ok, %ProduceCenterOrder{}}

      iex> delete_produce_center_order(produce_center_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_produce_center_order(%ProduceCenterOrder{} = produce_center_order) do
    Repo.delete(produce_center_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking produce_center_order changes.

  ## Examples

      iex> change_produce_center_order(produce_center_order)
      %Ecto.Changeset{source: %ProduceCenterOrder{}}

  """
  def change_produce_center_order(%ProduceCenterOrder{} = produce_center_order) do
    ProduceCenterOrder.changeset(produce_center_order, %{})
  end
end
