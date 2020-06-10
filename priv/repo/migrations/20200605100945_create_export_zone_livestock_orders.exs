defmodule Spider.Repo.Migrations.CreateExportZoneLivestockOrders do
  use Ecto.Migration

  def change do
    create table(:export_zone_livestock_orders) do
      add :dates, :map, default: %{}
      add :description, :string
      add :status, :integer

      add :export_zone_bundler_id, references(:export_zone_bundler, on_delete: :delete_all)
      add :livestock_order_stage_id, references(:livestock_order_stages, on_delete: :delete_all)
      add :livestock_order_id, references(:livestock_orders, on_delete: :nothing)

      timestamps()
    end

  end
end
