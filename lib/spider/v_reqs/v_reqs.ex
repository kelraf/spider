defmodule Spider.VReqs do
  @moduledoc """
  The VReqs context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.VReqs.VReq

  @doc """
  Returns the list of vreqs.

  ## Examples

      iex> list_vreqs()
      [%VReq{}, ...]

  """
  def list_vreqs do
    Repo.all(VReq)
  end

  @doc """
  Gets a single v_req.

  Raises `Ecto.NoResultsError` if the V req does not exist.

  ## Examples

      iex> get_v_req!(123)
      %VReq{}

      iex> get_v_req!(456)
      ** (Ecto.NoResultsError)

  """
  def get_v_req!(id), do: Repo.get!(VReq, id)

  @doc """
  Creates a v_req.

  ## Examples

      iex> create_v_req(%{field: value})
      {:ok, %VReq{}}

      iex> create_v_req(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_v_req(attrs \\ %{}) do
    %VReq{}
    |> VReq.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a v_req.

  ## Examples

      iex> update_v_req(v_req, %{field: new_value})
      {:ok, %VReq{}}

      iex> update_v_req(v_req, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_v_req(%VReq{} = v_req, attrs) do
    v_req
    |> VReq.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a VReq.

  ## Examples

      iex> delete_v_req(v_req)
      {:ok, %VReq{}}

      iex> delete_v_req(v_req)
      {:error, %Ecto.Changeset{}}

  """
  def delete_v_req(%VReq{} = v_req) do
    Repo.delete(v_req)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking v_req changes.

  ## Examples

      iex> change_v_req(v_req)
      %Ecto.Changeset{source: %VReq{}}

  """
  def change_v_req(%VReq{} = v_req) do
    VReq.changeset(v_req, %{})
  end
end
