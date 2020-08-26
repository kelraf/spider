defmodule Spider.CCPPOrders do
  @moduledoc """
  The CCPPOrders context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.CCPPOrders.CCPPOrder

  @doc """
  Returns the list of c_c_p_p_orders.

  ## Examples

      iex> list_c_c_p_p_orders()
      [%CCPPOrder{}, ...]

  """
  def list_c_c_p_p_orders do
    Repo.all(CCPPOrder)
  end

  @doc """
  Gets a single ccpp_order.

  Raises `Ecto.NoResultsError` if the Ccpp order does not exist.

  ## Examples

      iex> get_ccpp_order!(123)
      %CCPPOrder{}

      iex> get_ccpp_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ccpp_order!(id), do: Repo.get!(CCPPOrder, id)

  @doc """
  Creates a ccpp_order.

  ## Examples

      iex> create_ccpp_order(%{field: value})
      {:ok, %CCPPOrder{}}

      iex> create_ccpp_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ccpp_order(attrs \\ %{}) do
    %CCPPOrder{}
    |> CCPPOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ccpp_order.

  ## Examples

      iex> update_ccpp_order(ccpp_order, %{field: new_value})
      {:ok, %CCPPOrder{}}

      iex> update_ccpp_order(ccpp_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ccpp_order(%CCPPOrder{} = ccpp_order, attrs) do
    ccpp_order
    |> CCPPOrder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a CCPPOrder.

  ## Examples

      iex> delete_ccpp_order(ccpp_order)
      {:ok, %CCPPOrder{}}

      iex> delete_ccpp_order(ccpp_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ccpp_order(%CCPPOrder{} = ccpp_order) do
    Repo.delete(ccpp_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ccpp_order changes.

  ## Examples

      iex> change_ccpp_order(ccpp_order)
      %Ecto.Changeset{source: %CCPPOrder{}}

  """
  def change_ccpp_order(%CCPPOrder{} = ccpp_order) do
    CCPPOrder.changeset(ccpp_order, %{})
  end
end
