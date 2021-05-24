defmodule Spider.ProduceOrderContainers do
  @moduledoc """
  The ProduceOrderContainers context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.ProduceOrderContainers.ProduceOrderContainer

  @doc """
  Returns the list of produce_order_containers.

  ## Examples

      iex> list_produce_order_containers()
      [%ProduceOrderContainer{}, ...]

  """
  def list_produce_order_containers do
    Repo.all(ProduceOrderContainer)
  end

  @doc """
  Gets a single produce_order_container.

  Raises `Ecto.NoResultsError` if the Produce order container does not exist.

  ## Examples

      iex> get_produce_order_container!(123)
      %ProduceOrderContainer{}

      iex> get_produce_order_container!(456)
      ** (Ecto.NoResultsError)

  """
  def get_produce_order_container!(id), do: Repo.get!(ProduceOrderContainer, id)

  @doc """
  Creates a produce_order_container.

  ## Examples

      iex> create_produce_order_container(%{field: value})
      {:ok, %ProduceOrderContainer{}}

      iex> create_produce_order_container(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_produce_order_container(attrs \\ %{}) do
    %ProduceOrderContainer{}
    |> ProduceOrderContainer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a produce_order_container.

  ## Examples

      iex> update_produce_order_container(produce_order_container, %{field: new_value})
      {:ok, %ProduceOrderContainer{}}

      iex> update_produce_order_container(produce_order_container, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_produce_order_container(%ProduceOrderContainer{} = produce_order_container, attrs) do
    produce_order_container
    |> ProduceOrderContainer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ProduceOrderContainer.

  ## Examples

      iex> delete_produce_order_container(produce_order_container)
      {:ok, %ProduceOrderContainer{}}

      iex> delete_produce_order_container(produce_order_container)
      {:error, %Ecto.Changeset{}}

  """
  def delete_produce_order_container(%ProduceOrderContainer{} = produce_order_container) do
    Repo.delete(produce_order_container)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking produce_order_container changes.

  ## Examples

      iex> change_produce_order_container(produce_order_container)
      %Ecto.Changeset{source: %ProduceOrderContainer{}}

  """
  def change_produce_order_container(%ProduceOrderContainer{} = produce_order_container) do
    ProduceOrderContainer.changeset(produce_order_container, %{})
  end
end
