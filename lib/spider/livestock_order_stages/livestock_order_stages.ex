defmodule Spider.LivestockOrderStages do
  @moduledoc """
  The LivestockOrderStages context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.LivestockOrderStages.LivestockOrderStage
  # alias Spider.Context.LivestockOrderStagesCenterOrders

  @doc """
  Returns the list of livestock_order_stages.

  ## Examples

      iex> list_livestock_order_stages()
      [%LivestockOrderStage{}, ...]

  """
  def list_livestock_order_stages do
    Repo.all(LivestockOrderStage)
  end

  @doc """
  Gets a single livestock_order_stage.

  Raises `Ecto.NoResultsError` if the Livestock order stage does not exist.

  ## Examples

      iex> get_livestock_order_stage!(123)
      %LivestockOrderStage{}

      iex> get_livestock_order_stage!(456)
      ** (Ecto.NoResultsError)

  """
  def get_livestock_order_stage!(id), do: Repo.get!(LivestockOrderStage, id)

  @doc """
  Creates a livestock_order_stage.

  ## Examples

      iex> create_livestock_order_stage(%{field: value})
      {:ok, %LivestockOrderStage{}}

      iex> create_livestock_order_stage(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_livestock_order_stage(attrs \\ %{}) do
    %LivestockOrderStage{}
    |> LivestockOrderStage.changeset(attrs)
    |> Repo.insert()
    # |> StagesCenterOrders.spawn_task()
  end

  @doc """
  Updates a livestock_order_stage.

  ## Examples

      iex> update_livestock_order_stage(livestock_order_stage, %{field: new_value})
      {:ok, %LivestockOrderStage{}}

      iex> update_livestock_order_stage(livestock_order_stage, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_livestock_order_stage(%LivestockOrderStage{} = livestock_order_stage, attrs) do
    livestock_order_stage
    |> LivestockOrderStage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LivestockOrderStage.

  ## Examples

      iex> delete_livestock_order_stage(livestock_order_stage)
      {:ok, %LivestockOrderStage{}}

      iex> delete_livestock_order_stage(livestock_order_stage)
      {:error, %Ecto.Changeset{}}

  """
  def delete_livestock_order_stage(%LivestockOrderStage{} = livestock_order_stage) do
    Repo.delete(livestock_order_stage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking livestock_order_stage changes.

  ## Examples

      iex> change_livestock_order_stage(livestock_order_stage)
      %Ecto.Changeset{source: %LivestockOrderStage{}}

  """
  def change_livestock_order_stage(%LivestockOrderStage{} = livestock_order_stage) do
    LivestockOrderStage.changeset(livestock_order_stage, %{})
  end
end
