defmodule Spider.BusinessAssets do
  @moduledoc """
  The BusinessAssets context.
  """

  import Ecto.Query, warn: false
  alias Spider.Repo

  alias Spider.BusinessAssets.BusinessAsset
  alias Spider.Helpers.SpiderData

  @doc """
  Returns the list of business_assets.

  ## Examples

      iex> list_business_assets()
      [%BusinessAsset{}, ...]

  """
  def list_business_assets do
    Repo.all(BusinessAsset)
  end

  @doc """
  Gets a single business_asset.

  Raises `Ecto.NoResultsError` if the Business asset does not exist.

  ## Examples

      iex> get_business_asset!(123)
      %BusinessAsset{}

      iex> get_business_asset!(456)
      ** (Ecto.NoResultsError)

  """
  def get_business_asset!(id), do: Repo.get!(BusinessAsset, id)

  def get_business_assets_using_business_id(id) do
    
    query = from b in BusinessAsset,
                where: b.business_id == ^id,
                select: b
      
            business_assets = Repo.all(query)

    case business_assets |> SpiderData.list_empty? do
      true -> 
        {:empty, "Empty"}

      false ->
        {:ok, business_assets}
        
    end

  end

  @doc """
  Creates a business_asset.

  ## Examples

      iex> create_business_asset(%{field: value})
      {:ok, %BusinessAsset{}}

      iex> create_business_asset(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_business_asset(attrs \\ %{}) do
    %BusinessAsset{}
    |> BusinessAsset.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a business_asset.

  ## Examples

      iex> update_business_asset(business_asset, %{field: new_value})
      {:ok, %BusinessAsset{}}

      iex> update_business_asset(business_asset, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_business_asset(%BusinessAsset{} = business_asset, attrs) do
    business_asset
    |> BusinessAsset.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a BusinessAsset.

  ## Examples

      iex> delete_business_asset(business_asset)
      {:ok, %BusinessAsset{}}

      iex> delete_business_asset(business_asset)
      {:error, %Ecto.Changeset{}}

  """
  def delete_business_asset(%BusinessAsset{} = business_asset) do
    Repo.delete(business_asset)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking business_asset changes.

  ## Examples

      iex> change_business_asset(business_asset)
      %Ecto.Changeset{source: %BusinessAsset{}}

  """
  def change_business_asset(%BusinessAsset{} = business_asset) do
    BusinessAsset.changeset(business_asset, %{})
  end
end
