defmodule Spider.Produces do
  @moduledoc """
  The Produces context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.Produces.Produce

  @doc """
  Returns the list of produces.

  ## Examples

      iex> list_produces()
      [%Produce{}, ...]

  """
  def list_produces do
    Repo.all(Produce)
  end

  @doc """
  Gets a single produce.

  Raises `Ecto.NoResultsError` if the Produce does not exist.

  ## Examples

      iex> get_produce!(123)
      %Produce{}

      iex> get_produce!(456)
      ** (Ecto.NoResultsError)

  """
  def get_produce!(id), do: Repo.get!(Produce, id)

  @doc """
  Creates a produce.

  ## Examples

      iex> create_produce(%{field: value})
      {:ok, %Produce{}}

      iex> create_produce(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_produce(attrs \\ %{}) do
    %Produce{}
    |> Produce.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a produce.

  ## Examples

      iex> update_produce(produce, %{field: new_value})
      {:ok, %Produce{}}

      iex> update_produce(produce, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_produce(%Produce{} = produce, attrs) do
    produce
    |> Produce.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Produce.

  ## Examples

      iex> delete_produce(produce)
      {:ok, %Produce{}}

      iex> delete_produce(produce)
      {:error, %Ecto.Changeset{}}

  """
  def delete_produce(%Produce{} = produce) do
    Repo.delete(produce)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking produce changes.

  ## Examples

      iex> change_produce(produce)
      %Ecto.Changeset{source: %Produce{}}

  """
  def change_produce(%Produce{} = produce) do
    Produce.changeset(produce, %{})
  end
end
