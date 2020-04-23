defmodule Spider.DProduces do
  @moduledoc """
  The DProduces context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.DProduces.DProduce

  @doc """
  Returns the list of dproduces.

  ## Examples

      iex> list_dproduces()
      [%DProduce{}, ...]

  """
  def list_dproduces do
    Repo.all(DProduce)
  end

  @doc """
  Gets a single d_produce.

  Raises `Ecto.NoResultsError` if the D produce does not exist.

  ## Examples

      iex> get_d_produce!(123)
      %DProduce{}

      iex> get_d_produce!(456)
      ** (Ecto.NoResultsError)

  """
  def get_d_produce!(id), do: Repo.get!(DProduce, id)

  @doc """
  Creates a d_produce.

  ## Examples

      iex> create_d_produce(%{field: value})
      {:ok, %DProduce{}}

      iex> create_d_produce(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_d_produce(attrs \\ %{}) do
    %DProduce{}
    |> DProduce.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a d_produce.

  ## Examples

      iex> update_d_produce(d_produce, %{field: new_value})
      {:ok, %DProduce{}}

      iex> update_d_produce(d_produce, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_d_produce(%DProduce{} = d_produce, attrs) do
    d_produce
    |> DProduce.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DProduce.

  ## Examples

      iex> delete_d_produce(d_produce)
      {:ok, %DProduce{}}

      iex> delete_d_produce(d_produce)
      {:error, %Ecto.Changeset{}}

  """
  def delete_d_produce(%DProduce{} = d_produce) do
    Repo.delete(d_produce)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking d_produce changes.

  ## Examples

      iex> change_d_produce(d_produce)
      %Ecto.Changeset{source: %DProduce{}}

  """
  def change_d_produce(%DProduce{} = d_produce) do
    DProduce.changeset(d_produce, %{})
  end
end
