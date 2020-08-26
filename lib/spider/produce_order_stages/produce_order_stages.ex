defmodule Spider.ProduceOrderStages do
  @moduledoc """
  The ProduceOrderStages context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.ProduceOrderStages.ProduceOrderStage

  @doc """
  Returns the list of produce_order_stages.

  ## Examples

      iex> list_produce_order_stages()
      [%ProduceOrderStage{}, ...]

  """
  def list_produce_order_stages do
    Repo.all(ProduceOrderStage)
  end

  @doc """
  Gets a single produce_order_stage.

  Raises `Ecto.NoResultsError` if the Produce order stage does not exist.

  ## Examples

      iex> get_produce_order_stage!(123)
      %ProduceOrderStage{}

      iex> get_produce_order_stage!(456)
      ** (Ecto.NoResultsError)

  """
  def get_produce_order_stage!(id), do: Repo.get!(ProduceOrderStage, id)

  @doc """
  Creates a produce_order_stage.

  ## Examples

      iex> create_produce_order_stage(%{field: value})
      {:ok, %ProduceOrderStage{}}

      iex> create_produce_order_stage(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_produce_order_stage(attrs \\ %{}) do
    %ProduceOrderStage{}
    |> ProduceOrderStage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a produce_order_stage.

  ## Examples

      iex> update_produce_order_stage(produce_order_stage, %{field: new_value})
      {:ok, %ProduceOrderStage{}}

      iex> update_produce_order_stage(produce_order_stage, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_produce_order_stage(%ProduceOrderStage{} = produce_order_stage, attrs) do
    produce_order_stage
    |> ProduceOrderStage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ProduceOrderStage.

  ## Examples

      iex> delete_produce_order_stage(produce_order_stage)
      {:ok, %ProduceOrderStage{}}

      iex> delete_produce_order_stage(produce_order_stage)
      {:error, %Ecto.Changeset{}}

  """
  def delete_produce_order_stage(%ProduceOrderStage{} = produce_order_stage) do
    Repo.delete(produce_order_stage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking produce_order_stage changes.

  ## Examples

      iex> change_produce_order_stage(produce_order_stage)
      %Ecto.Changeset{source: %ProduceOrderStage{}}

  """
  def change_produce_order_stage(%ProduceOrderStage{} = produce_order_stage) do
    ProduceOrderStage.changeset(produce_order_stage, %{})
  end
end
