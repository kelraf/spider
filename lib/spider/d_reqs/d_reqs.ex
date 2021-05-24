defmodule Spider.DReqs do
  @moduledoc """
  The DReqs context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.DReqs.DReq

  @doc """
  Returns the list of dreqs.

  ## Examples

      iex> list_dreqs()
      [%DReq{}, ...]

  """
  def list_dreqs do
    Repo.all(DReq)
  end

  @doc """
  Gets a single d_req.

  Raises `Ecto.NoResultsError` if the D req does not exist.

  ## Examples

      iex> get_d_req!(123)
      %DReq{}

      iex> get_d_req!(456)
      ** (Ecto.NoResultsError)

  """
  def get_d_req!(id), do: Repo.get!(DReq, id)

  @doc """
  Creates a d_req.

  ## Examples

      iex> create_d_req(%{field: value})
      {:ok, %DReq{}}

      iex> create_d_req(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_d_req(attrs \\ %{}) do
    %DReq{}
    |> DReq.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a d_req.

  ## Examples

      iex> update_d_req(d_req, %{field: new_value})
      {:ok, %DReq{}}

      iex> update_d_req(d_req, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_d_req(%DReq{} = d_req, attrs) do
    d_req
    |> DReq.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DReq.

  ## Examples

      iex> delete_d_req(d_req)
      {:ok, %DReq{}}

      iex> delete_d_req(d_req)
      {:error, %Ecto.Changeset{}}

  """
  def delete_d_req(%DReq{} = d_req) do
    Repo.delete(d_req)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking d_req changes.

  ## Examples

      iex> change_d_req(d_req)
      %Ecto.Changeset{source: %DReq{}}

  """
  def change_d_req(%DReq{} = d_req) do
    DReq.changeset(d_req, %{})
  end
end
