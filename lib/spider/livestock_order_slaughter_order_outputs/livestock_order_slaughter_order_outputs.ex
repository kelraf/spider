defmodule Spider.LivestockOrderSlaughterOrderOutputs do
  @moduledoc """
  The LivestockOrderSlaughterOrderOutputs context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.LivestockOrderSlaughterOrderOutputs.LivestockOrderSlaughterOrderOutput

  @doc """
  Returns the list of livestock_order_slaughter_order_outputs.

  ## Examples

      iex> list_livestock_order_slaughter_order_outputs()
      [%LivestockOrderSlaughterOrderOutput{}, ...]

  """
  def list_livestock_order_slaughter_order_outputs do
    Repo.all(LivestockOrderSlaughterOrderOutput)
  end

  @doc """
  Gets a single livestock_order_slaughter_order_output.

  Raises `Ecto.NoResultsError` if the Livestock order slaughter order output does not exist.

  ## Examples

      iex> get_livestock_order_slaughter_order_output!(123)
      %LivestockOrderSlaughterOrderOutput{}

      iex> get_livestock_order_slaughter_order_output!(456)
      ** (Ecto.NoResultsError)

  """
  def get_livestock_order_slaughter_order_output!(id), do: Repo.get!(LivestockOrderSlaughterOrderOutput, id)

  @doc """
  Creates a livestock_order_slaughter_order_output.

  ## Examples

      iex> create_livestock_order_slaughter_order_output(%{field: value})
      {:ok, %LivestockOrderSlaughterOrderOutput{}}

      iex> create_livestock_order_slaughter_order_output(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_livestock_order_slaughter_order_output(attrs \\ %{}) do
    %LivestockOrderSlaughterOrderOutput{}
    |> LivestockOrderSlaughterOrderOutput.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a livestock_order_slaughter_order_output.

  ## Examples

      iex> update_livestock_order_slaughter_order_output(livestock_order_slaughter_order_output, %{field: new_value})
      {:ok, %LivestockOrderSlaughterOrderOutput{}}

      iex> update_livestock_order_slaughter_order_output(livestock_order_slaughter_order_output, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_livestock_order_slaughter_order_output(%LivestockOrderSlaughterOrderOutput{} = livestock_order_slaughter_order_output, attrs) do
    livestock_order_slaughter_order_output
    |> LivestockOrderSlaughterOrderOutput.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LivestockOrderSlaughterOrderOutput.

  ## Examples

      iex> delete_livestock_order_slaughter_order_output(livestock_order_slaughter_order_output)
      {:ok, %LivestockOrderSlaughterOrderOutput{}}

      iex> delete_livestock_order_slaughter_order_output(livestock_order_slaughter_order_output)
      {:error, %Ecto.Changeset{}}

  """
  def delete_livestock_order_slaughter_order_output(%LivestockOrderSlaughterOrderOutput{} = livestock_order_slaughter_order_output) do
    Repo.delete(livestock_order_slaughter_order_output)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking livestock_order_slaughter_order_output changes.

  ## Examples

      iex> change_livestock_order_slaughter_order_output(livestock_order_slaughter_order_output)
      %Ecto.Changeset{source: %LivestockOrderSlaughterOrderOutput{}}

  """
  def change_livestock_order_slaughter_order_output(%LivestockOrderSlaughterOrderOutput{} = livestock_order_slaughter_order_output) do
    LivestockOrderSlaughterOrderOutput.changeset(livestock_order_slaughter_order_output, %{})
  end
end
