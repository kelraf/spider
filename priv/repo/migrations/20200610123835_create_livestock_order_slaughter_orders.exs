defmodule Spider.Repo.Migrations.CreateLivestockOrderSlaughterOrders do
  use Ecto.Migration

  def change do
    create table(:livestock_order_slaughter_orders) do
      
      add :status, :integer
      add :description, :string
      add :dates, :map, default: %{}

      add :livestock_order_processing_stage_id, references(:livestock_order_processing_stages, on_delete: :delete_all)
      add :livestock_order_stage_id, references(:livestock_order_stages, on_delete: :delete_all)
      add :livestock_order_id, references(:livestock_orders, on_delete: :delete_all)

      timestamps()
    end

  end
end
