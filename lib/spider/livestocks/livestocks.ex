defmodule Spider.Livestocks do
  @moduledoc """
  The Livestocks context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.Livestocks.Livestock

  @doc """
  Returns the list of livestocks.

  ## Examples

      iex> list_livestocks()
      [%Livestock{}, ...]

  """
  def list_livestocks do
    Repo.all(Livestock)
  end

  @doc """
  Gets a single livestock.

  Raises `Ecto.NoResultsError` if the Livestock does not exist.

  ## Examples

      iex> get_livestock!(123)
      %Livestock{}

      iex> get_livestock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_livestock!(id), do: Repo.get!(Livestock, id)

  @doc """
  Creates a livestock.

  ## Examples

      iex> create_livestock(%{field: value})
      {:ok, %Livestock{}}

      iex> create_livestock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_livestock(attrs \\ %{}) do
    %Livestock{}
    |> Livestock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a livestock.

  ## Examples

      iex> update_livestock(livestock, %{field: new_value})
      {:ok, %Livestock{}}

      iex> update_livestock(livestock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_livestock(%Livestock{} = livestock, attrs) do
    livestock
    |> Livestock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Livestock.

  ## Examples

      iex> delete_livestock(livestock)
      {:ok, %Livestock{}}

      iex> delete_livestock(livestock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_livestock(%Livestock{} = livestock) do
    Repo.delete(livestock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking livestock changes.

  ## Examples

      iex> change_livestock(livestock)
      %Ecto.Changeset{source: %Livestock{}}

  """
  def change_livestock(%Livestock{} = livestock) do
    Livestock.changeset(livestock, %{})
  end
end
