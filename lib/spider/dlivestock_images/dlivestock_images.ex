defmodule Spider.DlivestockImages do
  @moduledoc """
  The DlivestockImages context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.DlivestockImages.DlivestockImage

  @doc """
  Returns the list of dlivestock_images.

  ## Examples

      iex> list_dlivestock_images()
      [%DlivestockImage{}, ...]

  """
  def list_dlivestock_images do
    Repo.all(DlivestockImage)
  end

  @doc """
  Gets a single dlivestock_image.

  Raises `Ecto.NoResultsError` if the Dlivestock image does not exist.

  ## Examples

      iex> get_dlivestock_image!(123)
      %DlivestockImage{}

      iex> get_dlivestock_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dlivestock_image!(id), do: Repo.get!(DlivestockImage, id)

  @doc """
  Creates a dlivestock_image.

  ## Examples

      iex> create_dlivestock_image(%{field: value})
      {:ok, %DlivestockImage{}}

      iex> create_dlivestock_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dlivestock_image(attrs \\ %{}) do
    %DlivestockImage{}
    |> DlivestockImage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dlivestock_image.

  ## Examples

      iex> update_dlivestock_image(dlivestock_image, %{field: new_value})
      {:ok, %DlivestockImage{}}

      iex> update_dlivestock_image(dlivestock_image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dlivestock_image(%DlivestockImage{} = dlivestock_image, attrs) do
    dlivestock_image
    |> DlivestockImage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DlivestockImage.

  ## Examples

      iex> delete_dlivestock_image(dlivestock_image)
      {:ok, %DlivestockImage{}}

      iex> delete_dlivestock_image(dlivestock_image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dlivestock_image(%DlivestockImage{} = dlivestock_image) do
    Repo.delete(dlivestock_image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dlivestock_image changes.

  ## Examples

      iex> change_dlivestock_image(dlivestock_image)
      %Ecto.Changeset{source: %DlivestockImage{}}

  """
  def change_dlivestock_image(%DlivestockImage{} = dlivestock_image) do
    DlivestockImage.changeset(dlivestock_image, %{})
  end
end
