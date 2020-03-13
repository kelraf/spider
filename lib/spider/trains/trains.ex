defmodule Spider.Trains do
  @moduledoc """
  The Trains context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.Trains.Train

  @doc """
  Returns the list of trains.

  ## Examples

      iex> list_trains()
      [%Train{}, ...]

  """
  def list_trains do
    Repo.all(Train)
  end

  @doc """
  Gets a single train.

  Raises `Ecto.NoResultsError` if the Train does not exist.

  ## Examples

      iex> get_train!(123)
      %Train{}

      iex> get_train!(456)
      ** (Ecto.NoResultsError)

  """
  def get_train!(id), do: Repo.get!(Train, id)

  @doc """
  Creates a train.

  ## Examples

      iex> create_train(%{field: value})
      {:ok, %Train{}}

      iex> create_train(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_train(attrs \\ %{}) do
    %Train{}
    |> Train.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a train.

  ## Examples

      iex> update_train(train, %{field: new_value})
      {:ok, %Train{}}

      iex> update_train(train, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_train(%Train{} = train, attrs) do
    train
    |> Train.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Train.

  ## Examples

      iex> delete_train(train)
      {:ok, %Train{}}

      iex> delete_train(train)
      {:error, %Ecto.Changeset{}}

  """
  def delete_train(%Train{} = train) do
    Repo.delete(train)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking train changes.

  ## Examples

      iex> change_train(train)
      %Ecto.Changeset{source: %Train{}}

  """
  def change_train(%Train{} = train) do
    Train.changeset(train, %{})
  end
end
