defmodule Spider.ProductImagesContainers do
  @moduledoc """
  The ProductImagesContainers context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.ProductImagesContainers.ProductImagesContainer

  @doc """
  Returns the list of product_container_images.

  ## Examples

      iex> list_product_container_images()
      [%ProductImagesContainer{}, ...]

  """
  def list_product_container_images do
    Repo.all(ProductImagesContainer)
  end

  @doc """
  Gets a single product_images_container.

  Raises `Ecto.NoResultsError` if the Product images container does not exist.

  ## Examples

      iex> get_product_images_container!(123)
      %ProductImagesContainer{}

      iex> get_product_images_container!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_images_container!(id), do: Repo.get!(ProductImagesContainer, id)

  @doc """
  Creates a product_images_container.

  ## Examples

      iex> create_product_images_container(%{field: value})
      {:ok, %ProductImagesContainer{}}

      iex> create_product_images_container(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_images_container(attrs \\ %{}) do
    %ProductImagesContainer{}
    |> ProductImagesContainer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_images_container.

  ## Examples

      iex> update_product_images_container(product_images_container, %{field: new_value})
      {:ok, %ProductImagesContainer{}}

      iex> update_product_images_container(product_images_container, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_images_container(%ProductImagesContainer{} = product_images_container, attrs) do
    product_images_container
    |> ProductImagesContainer.changeset(attrs, "update")
    |> Repo.update()
  end

  @doc """
  Deletes a ProductImagesContainer.

  ## Examples

      iex> delete_product_images_container(product_images_container)
      {:ok, %ProductImagesContainer{}}

      iex> delete_product_images_container(product_images_container)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_images_container(%ProductImagesContainer{} = product_images_container) do
    Repo.delete(product_images_container)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_images_container changes.

  ## Examples

      iex> change_product_images_container(product_images_container)
      %Ecto.Changeset{source: %ProductImagesContainer{}}

  """
  def change_product_images_container(%ProductImagesContainer{} = product_images_container) do
    ProductImagesContainer.changeset(product_images_container, %{})
  end
end
