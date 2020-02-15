defmodule Spider.Transtools do
  @moduledoc """
  The Transtools context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.Transtools.Transtool

  @doc """
  Returns the list of transtools.

  ## Examples

      iex> list_transtools()
      [%Transtool{}, ...]

  """
  def list_transtools do
    Repo.all(Transtool)
  end

  @doc """
  Gets a single transtool.

  Raises `Ecto.NoResultsError` if the Transtool does not exist.

  ## Examples

      iex> get_transtool!(123)
      %Transtool{}

      iex> get_transtool!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transtool!(id), do: Repo.get!(Transtool, id)

  @doc """
  Creates a transtool.

  ## Examples

      iex> create_transtool(%{field: value})
      {:ok, %Transtool{}}

      iex> create_transtool(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transtool(attrs \\ %{}) do
    %Transtool{}
    |> Transtool.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transtool.

  ## Examples

      iex> update_transtool(transtool, %{field: new_value})
      {:ok, %Transtool{}}

      iex> update_transtool(transtool, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transtool(%Transtool{} = transtool, attrs) do
    transtool
    |> Transtool.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Transtool.

  ## Examples

      iex> delete_transtool(transtool)
      {:ok, %Transtool{}}

      iex> delete_transtool(transtool)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transtool(%Transtool{} = transtool) do
    Repo.delete(transtool)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transtool changes.

  ## Examples

      iex> change_transtool(transtool)
      %Ecto.Changeset{source: %Transtool{}}

  """
  def change_transtool(%Transtool{} = transtool) do
    Transtool.changeset(transtool, %{})
  end
end
