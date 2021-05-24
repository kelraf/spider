defmodule Spider.Repo.Migrations.CreateLivestockOrderSlaughterOrderOutputs do
  use Ecto.Migration

  def change do
    create table(:livestock_order_slaughter_order_outputs) do

      add :quantity, :integer
      add :status, :integer

      add :d_livestock_slaughter_output_id, references(:d_livestock_slaughter_outputs, on_delete: :delete_all)
      add :livestock_order_slaughter_order_id, references(:livestock_order_slaughter_orders, on_delete: :delete_all)
      add :livestock_order_id, references(:livestock_orders, on_delete: :delete_all)
      add :livestock_order_stage_id, references(:livestock_order_stages, on_delete: :delete_all)
      add :livestock_order_processing_stage_id, references(:livestock_order_processing_stages, on_delete: :delete_all)

      timestamps()
    end

  end
end
