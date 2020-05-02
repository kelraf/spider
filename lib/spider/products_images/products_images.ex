defmodule Spider.ProductsImages do
  @moduledoc """
  The ProductsImages context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.ProductsImages.ProductImage

  @doc """
  Returns the list of prducts_images.

  ## Examples

      iex> list_prducts_images()
      [%ProductImage{}, ...]

  """
  def list_prducts_images do
    Repo.all(ProductImage)
  end

  @doc """
  Gets a single product_image.

  Raises `Ecto.NoResultsError` if the Product image does not exist.

  ## Examples

      iex> get_product_image!(123)
      %ProductImage{}

      iex> get_product_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_image!(id), do: Repo.get!(ProductImage, id)

  @doc """
  Creates a product_image.

  ## Examples

      iex> create_product_image(%{field: value})
      {:ok, %ProductImage{}}

      iex> create_product_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_image(attrs \\ %{}) do
    %ProductImage{}
    |> ProductImage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_image.

  ## Examples

      iex> update_product_image(product_image, %{field: new_value})
      {:ok, %ProductImage{}}

      iex> update_product_image(product_image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_image(%ProductImage{} = product_image, attrs) do
    product_image
    |> ProductImage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ProductImage.

  ## Examples

      iex> delete_product_image(product_image)
      {:ok, %ProductImage{}}

      iex> delete_product_image(product_image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_image(%ProductImage{} = product_image) do
    Repo.delete(product_image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_image changes.

  ## Examples

      iex> change_product_image(product_image)
      %Ecto.Changeset{source: %ProductImage{}}

  """
  def change_product_image(%ProductImage{} = product_image) do
    ProductImage.changeset(product_image, %{})
  end
end
