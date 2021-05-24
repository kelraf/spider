defmodule Spider.Froles do
  @moduledoc """
  The Froles context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.Froles.Frole

  @doc """
  Returns the list of froles.

  ## Examples

      iex> list_froles()
      [%Frole{}, ...]

  """
  def list_froles do
    Repo.all(Frole)
  end

  @doc """
  Gets a single frole.

  Raises `Ecto.NoResultsError` if the Frole does not exist.

  ## Examples

      iex> get_frole!(123)
      %Frole{}

      iex> get_frole!(456)
      ** (Ecto.NoResultsError)

  """
  def get_frole!(id), do: Repo.get!(Frole, id)

  @doc """
  Creates a frole.

  ## Examples

      iex> create_frole(%{field: value})
      {:ok, %Frole{}}

      iex> create_frole(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_frole(attrs \\ %{}) do
    %Frole{}
    |> Frole.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a frole.

  ## Examples

      iex> update_frole(frole, %{field: new_value})
      {:ok, %Frole{}}

      iex> update_frole(frole, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_frole(%Frole{} = frole, attrs) do
    frole
    |> Frole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Frole.

  ## Examples

      iex> delete_frole(frole)
      {:ok, %Frole{}}

      iex> delete_frole(frole)
      {:error, %Ecto.Changeset{}}

  """
  def delete_frole(%Frole{} = frole) do
    Repo.delete(frole)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking frole changes.

  ## Examples

      iex> change_frole(frole)
      %Ecto.Changeset{source: %Frole{}}

  """
  def change_frole(%Frole{} = frole) do
    Frole.changeset(frole, %{})
  end
end
