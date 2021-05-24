defmodule Spider.LivestockOrderProcessingStages do
  @moduledoc """
  The LivestockOrderProcessingStages context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.LivestockOrderProcessingStages.LivestockOrderProcessingStage

  @doc """
  Returns the list of livestock_order_processing_stages.

  ## Examples

      iex> list_livestock_order_processing_stages()
      [%LivestockOrderProcessingStage{}, ...]

  """
  def list_livestock_order_processing_stages do
    Repo.all(LivestockOrderProcessingStage)
  end

  @doc """
  Gets a single livestock_order_processing_stage.

  Raises `Ecto.NoResultsError` if the Livestock order processing stage does not exist.

  ## Examples

      iex> get_livestock_order_processing_stage!(123)
      %LivestockOrderProcessingStage{}

      iex> get_livestock_order_processing_stage!(456)
      ** (Ecto.NoResultsError)

  """
  def get_livestock_order_processing_stage!(id), do: Repo.get!(LivestockOrderProcessingStage, id)

  @doc """
  Creates a livestock_order_processing_stage.

  ## Examples

      iex> create_livestock_order_processing_stage(%{field: value})
      {:ok, %LivestockOrderProcessingStage{}}

      iex> create_livestock_order_processing_stage(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_livestock_order_processing_stage(attrs \\ %{}) do
    %LivestockOrderProcessingStage{}
    |> LivestockOrderProcessingStage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a livestock_order_processing_stage.

  ## Examples

      iex> update_livestock_order_processing_stage(livestock_order_processing_stage, %{field: new_value})
      {:ok, %LivestockOrderProcessingStage{}}

      iex> update_livestock_order_processing_stage(livestock_order_processing_stage, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_livestock_order_processing_stage(%LivestockOrderProcessingStage{} = livestock_order_processing_stage, attrs) do
    livestock_order_processing_stage
    |> LivestockOrderProcessingStage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LivestockOrderProcessingStage.

  ## Examples

      iex> delete_livestock_order_processing_stage(livestock_order_processing_stage)
      {:ok, %LivestockOrderProcessingStage{}}

      iex> delete_livestock_order_processing_stage(livestock_order_processing_stage)
      {:error, %Ecto.Changeset{}}

  """
  def delete_livestock_order_processing_stage(%LivestockOrderProcessingStage{} = livestock_order_processing_stage) do
    Repo.delete(livestock_order_processing_stage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking livestock_order_processing_stage changes.

  ## Examples

      iex> change_livestock_order_processing_stage(livestock_order_processing_stage)
      %Ecto.Changeset{source: %LivestockOrderProcessingStage{}}

  """
  def change_livestock_order_processing_stage(%LivestockOrderProcessingStage{} = livestock_order_processing_stage) do
    LivestockOrderProcessingStage.changeset(livestock_order_processing_stage, %{})
  end
end
