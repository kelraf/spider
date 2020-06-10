defmodule Spider.LivestockOrderContainers do
  @moduledoc """
  The LivestockOrderContainers context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.LivestockOrderContainers.LivestockOrderContainer
  alias Spider.Context.LivestockOrderStagesCenterOrders

  @doc """
  Returns the list of livestock_order_containers.

  ## Examples

      iex> list_livestock_order_containers()
      [%LivestockOrderContainer{}, ...]

  """
  def list_livestock_order_containers do
    Repo.all(LivestockOrderContainer)
  end

  @doc """
  Gets a single livestock_order_container.

  Raises `Ecto.NoResultsError` if the Livestock order container does not exist.

  ## Examples

      iex> get_livestock_order_container!(123)
      %LivestockOrderContainer{}

      iex> get_livestock_order_container!(456)
      ** (Ecto.NoResultsError)

  """
  def get_livestock_order_container!(id), do: Repo.get!(LivestockOrderContainer, id)

  @doc """
  Creates a livestock_order_container.

  ## Examples

      iex> create_livestock_order_container(%{field: value})
      {:ok, %LivestockOrderContainer{}}

      iex> create_livestock_order_container(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_livestock_order_container(attrs \\ %{}) do
    %LivestockOrderContainer{}
    |> LivestockOrderContainer.changeset(attrs)
    |> Repo.insert()
    |> LivestockOrderStagesCenterOrders.spawn_task()
  end

  @doc """
  Updates a livestock_order_container.

  ## Examples

      iex> update_livestock_order_container(livestock_order_container, %{field: new_value})
      {:ok, %LivestockOrderContainer{}}

      iex> update_livestock_order_container(livestock_order_container, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_livestock_order_container(%LivestockOrderContainer{} = livestock_order_container, attrs) do
    livestock_order_container
    |> LivestockOrderContainer.changeset(attrs, "update")
    |> Repo.update()
  end

  @doc """
  Deletes a LivestockOrderContainer.

  ## Examples

      iex> delete_livestock_order_container(livestock_order_container)
      {:ok, %LivestockOrderContainer{}}

      iex> delete_livestock_order_container(livestock_order_container)
      {:error, %Ecto.Changeset{}}

  """
  def delete_livestock_order_container(%LivestockOrderContainer{} = livestock_order_container) do
    Repo.delete(livestock_order_container)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking livestock_order_container changes.

  ## Examples

      iex> change_livestock_order_container(livestock_order_container)
      %Ecto.Changeset{source: %LivestockOrderContainer{}}

  """
  def change_livestock_order_container(%LivestockOrderContainer{} = livestock_order_container) do
    LivestockOrderContainer.changeset(livestock_order_container, %{})
  end
end
