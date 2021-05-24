defmodule Spider.Vessles do
  @moduledoc """
  The Vessles context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.Vessles.Vessle
  alias Spider.Helpers.SpiderData

  @doc """
  Returns the list of vessles.

  ## Examples

      iex> list_vessles()
      [%Vessle{}, ...]

  """
  def list_vessles do
    Repo.all(Vessle)
  end

  @doc """
  Gets a single vessle.

  Raises `Ecto.NoResultsError` if the Vessle does not exist.

  ## Examples

      iex> get_vessle!(123)
      %Vessle{}

      iex> get_vessle!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vessle!(id), do: Repo.get!(Vessle, id)

  def get_vessles_using_business_id(business_id) do
    
    query = from v in Vessle,
                where: v.business_id == ^business_id,
                select: v

    vessles = Repo.all(query)

    case vessles |> SpiderData.list_empty? do
      true -> 
        {:empty, "Empty"}

      false ->
        {:ok, vessles}
        
    end

  end

  @doc """
  Creates a vessle.

  ## Examples

      iex> create_vessle(%{field: value})
      {:ok, %Vessle{}}

      iex> create_vessle(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vessle(attrs \\ %{}) do
    %Vessle{}
    |> Vessle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vessle.

  ## Examples

      iex> update_vessle(vessle, %{field: new_value})
      {:ok, %Vessle{}}

      iex> update_vessle(vessle, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vessle(%Vessle{} = vessle, attrs) do
    vessle
    |> Vessle.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Vessle.

  ## Examples

      iex> delete_vessle(vessle)
      {:ok, %Vessle{}}

      iex> delete_vessle(vessle)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vessle(%Vessle{} = vessle) do
    Repo.delete(vessle)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vessle changes.

  ## Examples

      iex> change_vessle(vessle)
      %Ecto.Changeset{source: %Vessle{}}

  """
  def change_vessle(%Vessle{} = vessle) do
    Vessle.changeset(vessle, %{})
  end
end
