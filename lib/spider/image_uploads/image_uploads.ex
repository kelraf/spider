defmodule Spider.ImageUploads do
  @moduledoc """
  The ImageUploads context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.ImageUploads.ImageUpload

  @doc """
  Returns the list of imageuploads.

  ## Examples

      iex> list_imageuploads()
      [%ImageUpload{}, ...]

  """
  def list_imageuploads do
    Repo.all(ImageUpload)
  end

  @doc """
  Gets a single image_upload.

  Raises `Ecto.NoResultsError` if the Image upload does not exist.

  ## Examples

      iex> get_image_upload!(123)
      %ImageUpload{}

      iex> get_image_upload!(456)
      ** (Ecto.NoResultsError)

  """
  def get_image_upload!(id), do: Repo.get!(ImageUpload, id)

  @doc """
  Creates a image_upload.

  ## Examples

      iex> create_image_upload(%{field: value})
      {:ok, %ImageUpload{}}

      iex> create_image_upload(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_image_upload(attrs \\ %{}) do
    %ImageUpload{}
    |> ImageUpload.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a image_upload.

  ## Examples

      iex> update_image_upload(image_upload, %{field: new_value})
      {:ok, %ImageUpload{}}

      iex> update_image_upload(image_upload, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_image_upload(%ImageUpload{} = image_upload, attrs) do
    image_upload
    |> ImageUpload.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ImageUpload.

  ## Examples

      iex> delete_image_upload(image_upload)
      {:ok, %ImageUpload{}}

      iex> delete_image_upload(image_upload)
      {:error, %Ecto.Changeset{}}

  """
  def delete_image_upload(%ImageUpload{} = image_upload) do
    Repo.delete(image_upload)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking image_upload changes.

  ## Examples

      iex> change_image_upload(image_upload)
      %Ecto.Changeset{source: %ImageUpload{}}

  """
  def change_image_upload(%ImageUpload{} = image_upload) do
    ImageUpload.changeset(image_upload, %{})
  end
end
