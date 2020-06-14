defmodule Spider.DLivestockSlaughterOutputs do
  @moduledoc """
  The DLivestockSlaughterOutputs context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.DLivestockSlaughterOutputs.DLivestockSlaughterOutput
  alias Spider.Helpers.SpiderData

  @doc """
  Returns the list of d_livestock_slaughter_outputs.

  ## Examples

      iex> list_d_livestock_slaughter_outputs()
      [%DLivestockSlaughterOutput{}, ...]

  """
  def list_d_livestock_slaughter_outputs do
    Repo.all(DLivestockSlaughterOutput)
  end

  def get_d_livestock_slaughter_outputs_using_d_livestock_id(d_livestock_id) do
    
    query = from o in DLivestockSlaughterOutput,
                where: o.d_livestock_id == ^d_livestock_id,
                select: o

    d_livestock_slaughter_outputs = Repo.all(query)

    case d_livestock_slaughter_outputs |> SpiderData.list_empty? do
      true -> 
        {:empty, "Empty"}

      false ->
        {:ok, d_livestock_slaughter_outputs}
        
    end

  end

  @doc """
  Gets a single d_livestock_slaughter_output.

  Raises `Ecto.NoResultsError` if the D livestock slaughter output does not exist.

  ## Examples

      iex> get_d_livestock_slaughter_output!(123)
      %DLivestockSlaughterOutput{}

      iex> get_d_livestock_slaughter_output!(456)
      ** (Ecto.NoResultsError)

  """
  def get_d_livestock_slaughter_output!(id), do: Repo.get!(DLivestockSlaughterOutput, id)

  @doc """
  Creates a d_livestock_slaughter_output.

  ## Examples

      iex> create_d_livestock_slaughter_output(%{field: value})
      {:ok, %DLivestockSlaughterOutput{}}

      iex> create_d_livestock_slaughter_output(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_d_livestock_slaughter_output(attrs \\ %{}) do
    %DLivestockSlaughterOutput{}
    |> DLivestockSlaughterOutput.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a d_livestock_slaughter_output.

  ## Examples

      iex> update_d_livestock_slaughter_output(d_livestock_slaughter_output, %{field: new_value})
      {:ok, %DLivestockSlaughterOutput{}}

      iex> update_d_livestock_slaughter_output(d_livestock_slaughter_output, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_d_livestock_slaughter_output(%DLivestockSlaughterOutput{} = d_livestock_slaughter_output, attrs) do
    d_livestock_slaughter_output
    |> DLivestockSlaughterOutput.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DLivestockSlaughterOutput.

  ## Examples

      iex> delete_d_livestock_slaughter_output(d_livestock_slaughter_output)
      {:ok, %DLivestockSlaughterOutput{}}

      iex> delete_d_livestock_slaughter_output(d_livestock_slaughter_output)
      {:error, %Ecto.Changeset{}}

  """
  def delete_d_livestock_slaughter_output(%DLivestockSlaughterOutput{} = d_livestock_slaughter_output) do
    Repo.delete(d_livestock_slaughter_output)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking d_livestock_slaughter_output changes.

  ## Examples

      iex> change_d_livestock_slaughter_output(d_livestock_slaughter_output)
      %Ecto.Changeset{source: %DLivestockSlaughterOutput{}}

  """
  def change_d_livestock_slaughter_output(%DLivestockSlaughterOutput{} = d_livestock_slaughter_output) do
    DLivestockSlaughterOutput.changeset(d_livestock_slaughter_output, %{})
  end
end
