defmodule Spider.TLivestocks do
  @moduledoc """
  The TLivestocks context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.TLivestocks.TLivestock

  @doc """
  Returns the list of tlivestocks.

  ## Examples

      iex> list_tlivestocks()
      [%TLivestock{}, ...]

  """
  def list_tlivestocks do
    Repo.all(TLivestock)
  end

  @doc """
  Gets a single t_livestock.

  Raises `Ecto.NoResultsError` if the T livestock does not exist.

  ## Examples

      iex> get_t_livestock!(123)
      %TLivestock{}

      iex> get_t_livestock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_t_livestock!(id), do: Repo.get!(TLivestock, id)

  @doc """
  Creates a t_livestock.

  ## Examples

      iex> create_t_livestock(%{field: value})
      {:ok, %TLivestock{}}

      iex> create_t_livestock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_t_livestock(attrs \\ %{}) do
    %TLivestock{}
    |> TLivestock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a t_livestock.

  ## Examples

      iex> update_t_livestock(t_livestock, %{field: new_value})
      {:ok, %TLivestock{}}

      iex> update_t_livestock(t_livestock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_t_livestock(%TLivestock{} = t_livestock, attrs) do
    t_livestock
    |> TLivestock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TLivestock.

  ## Examples

      iex> delete_t_livestock(t_livestock)
      {:ok, %TLivestock{}}

      iex> delete_t_livestock(t_livestock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_t_livestock(%TLivestock{} = t_livestock) do
    Repo.delete(t_livestock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking t_livestock changes.

  ## Examples

      iex> change_t_livestock(t_livestock)
      %Ecto.Changeset{source: %TLivestock{}}

  """
  def change_t_livestock(%TLivestock{} = t_livestock) do
    TLivestock.changeset(t_livestock, %{})
  end
end
