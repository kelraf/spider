defmodule Spider.CCPLOrders do
  @moduledoc """
  The CCPLOrders context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.CCPLOrders.CCPLOrder

  @doc """
  Returns the list of c_c_p_l_orders.

  ## Examples

      iex> list_c_c_p_l_orders()
      [%CCPLOrder{}, ...]

  """
  def list_c_c_p_l_orders do
    Repo.all(CCPLOrder)
  end

  @doc """
  Gets a single ccpl_order.

  Raises `Ecto.NoResultsError` if the Ccpl order does not exist.

  ## Examples

      iex> get_ccpl_order!(123)
      %CCPLOrder{}

      iex> get_ccpl_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ccpl_order!(id), do: Repo.get!(CCPLOrder, id)

  @doc """
  Creates a ccpl_order.

  ## Examples

      iex> create_ccpl_order(%{field: value})
      {:ok, %CCPLOrder{}}

      iex> create_ccpl_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ccpl_order(attrs \\ %{}) do
    %CCPLOrder{}
    |> CCPLOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ccpl_order.

  ## Examples

      iex> update_ccpl_order(ccpl_order, %{field: new_value})
      {:ok, %CCPLOrder{}}

      iex> update_ccpl_order(ccpl_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ccpl_order(%CCPLOrder{} = ccpl_order, attrs) do
    ccpl_order
    |> CCPLOrder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a CCPLOrder.

  ## Examples

      iex> delete_ccpl_order(ccpl_order)
      {:ok, %CCPLOrder{}}

      iex> delete_ccpl_order(ccpl_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ccpl_order(%CCPLOrder{} = ccpl_order) do
    Repo.delete(ccpl_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ccpl_order changes.

  ## Examples

      iex> change_ccpl_order(ccpl_order)
      %Ecto.Changeset{source: %CCPLOrder{}}

  """
  def change_ccpl_order(%CCPLOrder{} = ccpl_order) do
    CCPLOrder.changeset(ccpl_order, %{})
  end
end
