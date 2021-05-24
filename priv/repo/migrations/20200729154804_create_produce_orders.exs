defmodule Spider.Repo.Migrations.CreateProduceOrders do
  use Ecto.Migration

  def change do
    create table(:produce_orders) do
      add :price_per_unit, :integer
      add :quantity, :integer
      add :total_cost, :integer

      add :produce_order_container_id, references(:produce_order_containers, on_delete: :delete_all)
      add :d_produce_id, references(:dproduces, on_delete: :delete_all)

      timestamps()
    end

  end
end
