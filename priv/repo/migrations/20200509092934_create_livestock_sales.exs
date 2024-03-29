defmodule Spider.Repo.Migrations.CreateLivestockSales do
  use Ecto.Migration

  def change do
    create table(:livestock_sales) do
      add :quantity, :integer
      add :price_per_animal, :integer
      add :total_price, :integer
      add :status, :integer, defaulf: 1
      add :payment_status, :integer, default: 1

      add :d_livestock_id, references(:dlivestock, on_delete: :delete_all)
      add :center_order_id, references(:center_orders, on_delete: :delete_all)
      add :livestock_id, references(:livestocks, on_delete: :delete_all)
      add :business_id, references(:businesses, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

  end
end
