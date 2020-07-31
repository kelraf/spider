defmodule Spider.ProduceOrders do
  @moduledoc """
  The ProduceOrders context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.ProduceOrders.ProduceOrder

  @doc """
  Returns the list of produce_orders.

  ## Examples

      iex> list_produce_orders()
      [%ProduceOrder{}, ...]

  """
  def list_produce_orders do
    Repo.all(ProduceOrder)
  end

  @doc """
  Gets a single produce_order.

  Raises `Ecto.NoResultsError` if the Produce order does not exist.

  ## Examples

      iex> get_produce_order!(123)
      %ProduceOrder{}

      iex> get_produce_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_produce_order!(id), do: Repo.get!(ProduceOrder, id)

  @doc """
  Creates a produce_order.

  ## Examples

      iex> create_produce_order(%{field: value})
      {:ok, %ProduceOrder{}}

      iex> create_produce_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_produce_order(attrs \\ %{}) do
    %ProduceOrder{}
    |> ProduceOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a produce_order.

  ## Examples

      iex> update_produce_order(produce_order, %{field: new_value})
      {:ok, %ProduceOrder{}}

      iex> update_produce_order(produce_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_produce_order(%ProduceOrder{} = produce_order, attrs) do
    produce_order
    |> ProduceOrder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ProduceOrder.

  ## Examples

      iex> delete_produce_order(produce_order)
      {:ok, %ProduceOrder{}}

      iex> delete_produce_order(produce_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_produce_order(%ProduceOrder{} = produce_order) do
    Repo.delete(produce_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking produce_order changes.

  ## Examples

      iex> change_produce_order(produce_order)
      %Ecto.Changeset{source: %ProduceOrder{}}

  """
  def change_produce_order(%ProduceOrder{} = produce_order) do
    ProduceOrder.changeset(produce_order, %{})
  end
end
