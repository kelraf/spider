defmodule Spider.Repo.Migrations.CreateLivestockOrderSlaughterOrders do
  use Ecto.Migration

  def change do
    create table(:livestock_order_slaughter_orders) do
      
      add :status, :integer
      add :description, :text
      add :dates, :map, default: %{}

      add :slaughter_order_bundler_id, references(:slaughter_order_bundlers, on_delete: :delete_all)
      add :business_id, references(:businesses, on_delete: :nothing)
      add :livestock_order_processing_stage_id, references(:livestock_order_processing_stages, on_delete: :delete_all)
      add :livestock_order_stage_id, references(:livestock_order_stages, on_delete: :delete_all)
      add :livestock_order_id, references(:livestock_orders, on_delete: :delete_all)

      timestamps()
    end

  end
end
