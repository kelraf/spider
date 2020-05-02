defmodule Spider.Repo.Migrations.CreateProductContainerImages do
  use Ecto.Migration

  def change do
    create table(:product_container_images) do

      add :product_id, references(:products, on_delete: :delete_all)
      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

  end
end
