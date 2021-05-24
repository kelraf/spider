defmodule Spider.OrderContainers do
  @moduledoc """
  The OrderContainers context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.OrderContainers.OrderContainer
  alias Spider.Helpers.SpiderData

  @doc """
  Returns the list of ordercontainers.

  ## Examples

      iex> list_ordercontainers()
      [%OrderContainer{}, ...]

  """
  def list_ordercontainers do
    Repo.all(OrderContainer)
  end

  @doc """
  Gets a single order_container.

  Raises `Ecto.NoResultsError` if the Order container does not exist.

  ## Examples

      iex> get_order_container!(123)
      %OrderContainer{}

      iex> get_order_container!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_container!(id), do: Repo.get!(OrderContainer, id)

  def get_order_container_using_business_id(business_id) do
    
    query = from oc in OrderContainer,
                where: oc.business_id == ^business_id,
                select: oc
      
      order_containers= Repo.all(query)

    case order_containers |> SpiderData.list_empty? do
      true -> 
        {:empty, "Empty"}

      false ->
        {:ok, order_containers}
        
    end

  end

  @doc """
  Creates a order_container.

  ## Examples

      iex> create_order_container(%{field: value})
      {:ok, %OrderContainer{}}

      iex> create_order_container(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order_container(attrs \\ %{}) do
    %OrderContainer{}
    |> OrderContainer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order_container.

  ## Examples

      iex> update_order_container(order_container, %{field: new_value})
      {:ok, %OrderContainer{}}

      iex> update_order_container(order_container, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order_container(%OrderContainer{} = order_container, attrs) do
    order_container
    |> OrderContainer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a OrderContainer.

  ## Examples

      iex> delete_order_container(order_container)
      {:ok, %OrderContainer{}}

      iex> delete_order_container(order_container)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order_container(%OrderContainer{} = order_container) do
    Repo.delete(order_container)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_container changes.

  ## Examples

      iex> change_order_container(order_container)
      %Ecto.Changeset{source: %OrderContainer{}}

  """
  def change_order_container(%OrderContainer{} = order_container) do
    OrderContainer.changeset(order_container, %{})
  end
end
