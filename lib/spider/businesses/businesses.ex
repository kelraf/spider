defmodule Spider.Businesses do
  @moduledoc """
  The Businesses context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.Businesses.Business
  alias  Spider.TranstoolKit

  @doc """
  Returns the list of businesses.

  ## Examples

      iex> list_businesses()
      [%Business{}, ...]

  """
  def list_businesses do
    Repo.all(Business)
  end

  @doc """
  Get all Businesses belonging to a particular user i.e using user id
  
  ## Examples

    iex> get_businesses_using_user_id(user_id)
    {:ok, [%Business{}, ...]}

    iex> get_businesses_using_user_id(user_id)
    {:empty, "Empty"}

  """
  def get_businesses_using_user_id(user_id) do

    query = from b in Business,
                where: b.user_id == ^user_id,
                select: b

    businesses = Repo.all query

    case businesses |> TranstoolKit.list_empty do

      true ->

        {:empty, "Empty"}

      false -> 

        {:ok, businesses}
        
    end

  end

  @doc """
  Gets a single business.

  Raises `Ecto.NoResultsError` if the Business does not exist.

  ## Examples

      iex> get_business!(123)
      %Business{}

      iex> get_business!(456)
      ** (Ecto.NoResultsError)

  """
  def get_business!(id), do: Repo.get!(Business, id)

  @doc """
  Creates a business.

  ## Examples

      iex> create_business(%{field: value})
      {:ok, %Business{}}

      iex> create_business(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_business(attrs \\ %{}) do
    %Business{}
    |> Business.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a business.

  ## Examples

      iex> update_business(business, %{field: new_value})
      {:ok, %Business{}}

      iex> update_business(business, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_business(%Business{} = business, attrs) do
    business
    |> Business.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Business.

  ## Examples

      iex> delete_business(business)
      {:ok, %Business{}}

      iex> delete_business(business)
      {:error, %Ecto.Changeset{}}

  """
  def delete_business(%Business{} = business) do
    Repo.delete(business)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking business changes.

  ## Examples

      iex> change_business(business)
      %Ecto.Changeset{source: %Business{}}

  """
  def change_business(%Business{} = business) do
    Business.changeset(business, %{})
  end
end
