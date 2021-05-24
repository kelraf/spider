defmodule Spider.DLivestocks do
  @moduledoc """
  The DLivestocks context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.DLivestocks.DLivestock

  @doc """
  Returns the list of dlivestock.

  ## Examples

      iex> list_dlivestock()
      [%DLivestock{}, ...]

  """
  def list_dlivestock do
    Repo.all(DLivestock)
  end

  @doc """
  Gets a single d_livestock.

  Raises `Ecto.NoResultsError` if the D livestock does not exist.

  ## Examples

      iex> get_d_livestock!(123)
      %DLivestock{}

      iex> get_d_livestock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_d_livestock!(id), do: Repo.get!(DLivestock, id)

  @doc """
  Creates a d_livestock.

  ## Examples

      iex> create_d_livestock(%{field: value})
      {:ok, %DLivestock{}}

      iex> create_d_livestock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_d_livestock(attrs \\ %{}) do
    %DLivestock{}
    |> DLivestock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a d_livestock.

  ## Examples

      iex> update_d_livestock(d_livestock, %{field: new_value})
      {:ok, %DLivestock{}}

      iex> update_d_livestock(d_livestock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_d_livestock(%DLivestock{} = d_livestock, attrs) do
    d_livestock
    |> DLivestock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DLivestock.

  ## Examples

      iex> delete_d_livestock(d_livestock)
      {:ok, %DLivestock{}}

      iex> delete_d_livestock(d_livestock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_d_livestock(%DLivestock{} = d_livestock) do
    Repo.delete(d_livestock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking d_livestock changes.

  ## Examples

      iex> change_d_livestock(d_livestock)
      %Ecto.Changeset{source: %DLivestock{}}

  """
  def change_d_livestock(%DLivestock{} = d_livestock) do
    DLivestock.changeset(d_livestock, %{})
  end
end
