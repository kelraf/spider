defmodule Spider.Repo.Migrations.CreateLivestockOrders do
  use Ecto.Migration

  def change do
    create table(:livestock_orders) do

      add :price, :integer
      add :total_cost, :integer
      add :quantity, :integer
      add :livestock_order_container_id, references(:livestock_order_containers, on_delete: :delete_all)
      add :dlivestock_id, references(:dlivestock, on_delete: :nothing)

      timestamps()
    end

  end
end
