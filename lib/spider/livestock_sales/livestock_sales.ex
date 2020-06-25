defmodule Spider.LivestockSales do
  @moduledoc """
  The LivestockSales context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.LivestockSales.LivestockSale
  alias Spider.CenterOrders.CenterOrder
  alias Spider.Livestocks.Livestock

  @doc """
  Returns the list of livestock_sales.

  ## Examples

      iex> list_livestock_sales()
      [%LivestockSale{}, ...]

  """
  def list_livestock_sales do
    Repo.all(LivestockSale)
  end

  @doc """
  Gets a single livestock_sale.

  Raises `Ecto.NoResultsError` if the Livestock sale does not exist.

  ## Examples

      iex> get_livestock_sale!(123)
      %LivestockSale{}

      iex> get_livestock_sale!(456)
      ** (Ecto.NoResultsError)

  """
  def get_livestock_sale!(id), do: Repo.get!(LivestockSale, id)

  @doc """
  Creates a livestock_sale.

  ## Examples

      iex> create_livestock_sale(%{field: value})
      {:ok, %LivestockSale{}}

      iex> create_livestock_sale(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_livestock_sale(attrs \\ %{}) do
    case create_livestock_sale_transation(attrs) do
      {:ok, transaction_results} ->
        transaction_results
      _ ->
        {
          :error,
            action: :insert,
            changes: %{},
            errors: [
              transation: {"Failed"}              
            ],
            valid?: false
          }
    end
  end

  @doc """
  Updates a livestock_sale.

  ## Examples

      iex> update_livestock_sale(livestock_sale, %{field: new_value})
      {:ok, %LivestockSale{}}

      iex> update_livestock_sale(livestock_sale, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_livestock_sale(%LivestockSale{} = livestock_sale, attrs) do
    case update_livestock_sale_transation(livestock_sale, attrs) do
      {:ok, transaction_results} ->
        transaction_results
      _ ->
        {
          :error,
            action: :insert,
            changes: %{},
            errors: [
              transation: {"Failed"}              
            ],
            valid?: false
          }
    end
  end

  defp create_livestock_sale_transation(attrs) do

    Repo.transaction(fn -> 

      livestock_sale_changeset = LivestockSale.changeset(%LivestockSale{}, attrs)
      livestock_sale = Repo.insert(livestock_sale_changeset)

      case livestock_sale do

        {:error, _ecto_error} ->
          livestock_sale
        {:ok, _success} ->

          center_order = CenterOrder.changeset(%CenterOrder{} = livestock_sale_changeset.changes.center_order_item.center_order, livestock_sale_changeset.changes.center_order_item.new_center_order_params, "update") |> Repo.update!()
          livestock = Livestock.changeset(%Livestock{} = livestock_sale_changeset.changes.livestock_item.livestock, livestock_sale_changeset.changes.livestock_item.new_livestock_params, "update") |> Repo.update!()
          livestock_sale

      end

    end)
  end

  defp update_livestock_sale_transation(old_livestock_sale, attrs) do

    Repo.transaction(fn -> 

      livestock_sale_changeset = LivestockSale.changeset(%LivestockSale{} = old_livestock_sale, attrs, "update")
      livestock_sale = Repo.update(livestock_sale_changeset)

      case livestock_sale do

        {:error, _ecto_error} ->
          livestock_sale
        {:ok, _success} ->

          center_order = CenterOrder.changeset(%CenterOrder{} = livestock_sale_changeset.changes.center_order_item.center_order, livestock_sale_changeset.changes.center_order_item.new_center_order_params, "update") |> Repo.update!()
          livestock = Livestock.changeset(%Livestock{} = livestock_sale_changeset.changes.livestock_item.livestock, livestock_sale_changeset.changes.livestock_item.new_livestock_params, "update") |> Repo.update!()
          livestock_sale

      end

    end)
  end

  @doc """
  Deletes a LivestockSale.

  ## Examples

      iex> delete_livestock_sale(livestock_sale)
      {:ok, %LivestockSale{}}

      iex> delete_livestock_sale(livestock_sale)
      {:error, %Ecto.Changeset{}}

  """
  def delete_livestock_sale(%LivestockSale{} = livestock_sale) do
    Repo.delete(livestock_sale)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking livestock_sale changes.

  ## Examples

      iex> change_livestock_sale(livestock_sale)
      %Ecto.Changeset{source: %LivestockSale{}}

  """
  def change_livestock_sale(%LivestockSale{} = livestock_sale) do
    LivestockSale.changeset(livestock_sale, %{})
  end
end
