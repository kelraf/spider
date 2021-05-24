defmodule Spider.Repo.Migrations.CreateProductsImages do
  use Ecto.Migration

  def change do
    create table(:products_images) do
      
      add :uuid, :string

      add :product_images_container_id, references(:product_container_images, on_delete: :delete_all)
      add :product_id, references(:products, on_delete: :delete_all)
      add :image, :string

      timestamps()
    end

  end
end
