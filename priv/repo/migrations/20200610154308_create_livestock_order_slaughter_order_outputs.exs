defmodule Spider.Repo.Migrations.CreateLivestockOrderSlaughterOrderOutputs do
  use Ecto.Migration

  def change do
    create table(:livestock_order_slaughter_order_outputs) do

      add :output_name, :string
      add :quantity, :integer
      add :units, :string
      add :status, :integer

      add :livestock_order_slaughter_order_id, references(:livestock_order_slaughter_orders, on_delete: :delete_all)
      add :livestock_order_id, references(:livestock_orders, on_delete: :delete_all)
      add :livestock_order_stage_id, references(:livestock_order_stages, on_delete: :delete_all)
      add :livestock_order_processing_stage_id, references(:livestock_order_processing_stages, on_delete: :delete_all)

      timestamps()
    end

  end
end
