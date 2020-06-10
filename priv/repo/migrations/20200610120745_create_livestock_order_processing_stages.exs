defmodule Spider.Repo.Migrations.CreateLivestockOrderProcessingStages do
  use Ecto.Migration

  def change do
    create table(:livestock_order_processing_stages) do
      add :stage_name, :string
      add :status, :integer, default: 1

      add :livestock_order_stage_id, references(:livestock_order_stages, on_delete: :delete_all)
      add :livestock_order_id, references(:livestock_orders, on_delete: :delete_all)

      timestamps()
    end

  end
end
