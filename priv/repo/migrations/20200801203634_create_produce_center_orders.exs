defmodule Spider.Repo.Migrations.CreateProduceCenterOrders do
  use Ecto.Migration

  def change do
    create table(:produce_center_orders) do
      add :required_quantity, :integer
      add :available_quantity, :integer
      add :description, :text
      add :status, :string
      add :total_cost, :integer
      add :who_can_see, {:array, :jsonb}
      add :dates, :map, default: %{}

      add :produce_order_stage_id, references(:produce_order_stages, on_delete: :delete_all)
      add :produce_order_id, references(:produce_orders, on_delete: :delete_all)
      add :d_produce_id, references(:dproduces, on_delete: :delete_all)

      timestamps()
    end

  end
end
