defmodule Spider.Traincs do
  @moduledoc """
  The Traincs context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.Traincs.Trainc

  @doc """
  Returns the list of traincs.

  ## Examples

      iex> list_traincs()
      [%Trainc{}, ...]

  """
  def list_traincs do
    Repo.all(Trainc)
  end

  @doc """
  Gets a single trainc.

  Raises `Ecto.NoResultsError` if the Trainc does not exist.

  ## Examples

      iex> get_trainc!(123)
      %Trainc{}

      iex> get_trainc!(456)
      ** (Ecto.NoResultsError)

  """
  def get_trainc!(id), do: Repo.get!(Trainc, id)

  @doc """
  Creates a trainc.

  ## Examples

      iex> create_trainc(%{field: value})
      {:ok, %Trainc{}}

      iex> create_trainc(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_trainc(attrs \\ %{}) do
    %Trainc{}
    |> Trainc.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a trainc.

  ## Examples

      iex> update_trainc(trainc, %{field: new_value})
      {:ok, %Trainc{}}

      iex> update_trainc(trainc, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_trainc(%Trainc{} = trainc, attrs) do
    trainc
    |> Trainc.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Trainc.

  ## Examples

      iex> delete_trainc(trainc)
      {:ok, %Trainc{}}

      iex> delete_trainc(trainc)
      {:error, %Ecto.Changeset{}}

  """
  def delete_trainc(%Trainc{} = trainc) do
    Repo.delete(trainc)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking trainc changes.

  ## Examples

      iex> change_trainc(trainc)
      %Ecto.Changeset{source: %Trainc{}}

  """
  def change_trainc(%Trainc{} = trainc) do
    Trainc.changeset(trainc, %{})
  end
end
