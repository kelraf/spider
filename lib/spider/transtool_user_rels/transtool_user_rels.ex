defmodule Spider.TranstoolUserRels do
  @moduledoc """
  The TranstoolUserRels context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.TranstoolUserRels.TranstoolUserRel

  @doc """
  Returns the list of transtooluserrels.

  ## Examples

      iex> list_transtooluserrels()
      [%TranstoolUserRel{}, ...]

  """
  def list_transtooluserrels do
    Repo.all(TranstoolUserRel)
  end

  @doc """
  Gets a single transtool_user_rel.

  Raises `Ecto.NoResultsError` if the Transtool user rel does not exist.

  ## Examples

      iex> get_transtool_user_rel!(123)
      %TranstoolUserRel{}

      iex> get_transtool_user_rel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transtool_user_rel!(id), do: Repo.get!(TranstoolUserRel, id)

  @doc """
  Creates a transtool_user_rel.

  ## Examples

      iex> create_transtool_user_rel(%{field: value})
      {:ok, %TranstoolUserRel{}}

      iex> create_transtool_user_rel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transtool_user_rel(attrs \\ %{}) do
    %TranstoolUserRel{}
    |> TranstoolUserRel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transtool_user_rel.

  ## Examples

      iex> update_transtool_user_rel(transtool_user_rel, %{field: new_value})
      {:ok, %TranstoolUserRel{}}

      iex> update_transtool_user_rel(transtool_user_rel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transtool_user_rel(%TranstoolUserRel{} = transtool_user_rel, attrs) do
    transtool_user_rel
    |> TranstoolUserRel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TranstoolUserRel.

  ## Examples

      iex> delete_transtool_user_rel(transtool_user_rel)
      {:ok, %TranstoolUserRel{}}

      iex> delete_transtool_user_rel(transtool_user_rel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transtool_user_rel(%TranstoolUserRel{} = transtool_user_rel) do
    Repo.delete(transtool_user_rel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transtool_user_rel changes.

  ## Examples

      iex> change_transtool_user_rel(transtool_user_rel)
      %Ecto.Changeset{source: %TranstoolUserRel{}}

  """
  def change_transtool_user_rel(%TranstoolUserRel{} = transtool_user_rel) do
    TranstoolUserRel.changeset(transtool_user_rel, %{})
  end
end
