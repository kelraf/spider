defmodule Spider.TransporterContainers do
  @moduledoc """
  The TransporterContainers context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.TransporterContainers.TransporterContainer

  @doc """
  Returns the list of transportercontainer.

  ## Examples

      iex> list_transportercontainer()
      [%TransporterContainer{}, ...]

  """
  def list_transportercontainer do
    Repo.all(TransporterContainer)
  end

  @doc """
  Gets a single transporter_container.

  Raises `Ecto.NoResultsError` if the Transporter container does not exist.

  ## Examples

      iex> get_transporter_container!(123)
      %TransporterContainer{}

      iex> get_transporter_container!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transporter_container!(id), do: Repo.get!(TransporterContainer, id)

  @doc """
  Creates a transporter_container.

  ## Examples

      iex> create_transporter_container(%{field: value})
      {:ok, %TransporterContainer{}}

      iex> create_transporter_container(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transporter_container(attrs \\ %{}) do
    %TransporterContainer{}
    |> TransporterContainer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transporter_container.

  ## Examples

      iex> update_transporter_container(transporter_container, %{field: new_value})
      {:ok, %TransporterContainer{}}

      iex> update_transporter_container(transporter_container, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transporter_container(%TransporterContainer{} = transporter_container, attrs) do
    transporter_container
    |> TransporterContainer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TransporterContainer.

  ## Examples

      iex> delete_transporter_container(transporter_container)
      {:ok, %TransporterContainer{}}

      iex> delete_transporter_container(transporter_container)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transporter_container(%TransporterContainer{} = transporter_container) do
    Repo.delete(transporter_container)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transporter_container changes.

  ## Examples

      iex> change_transporter_container(transporter_container)
      %Ecto.Changeset{source: %TransporterContainer{}}

  """
  def change_transporter_container(%TransporterContainer{} = transporter_container) do
    TransporterContainer.changeset(transporter_container, %{})
  end
end
