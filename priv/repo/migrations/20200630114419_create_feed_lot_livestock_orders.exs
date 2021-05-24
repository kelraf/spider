defmodule Spider.Repo.Migrations.CreateFeedLotLivestockOrders do
  use Ecto.Migration

  def change do
    create table(:feed_lot_livestock_orders) do

      add :dates, :map, default: %{}
      add :status, :integer, default: 1

      add :feed_lot_bundler_id, references(:feed_lot_bundlers, on_delete: :delete_all)
      add :livestock_order_stage_id, references(:livestock_order_stages, on_delete: :delete_all)
      add :livestock_order_id, references(:livestock_orders, on_delete: :delete_all)

      timestamps()
    end

  end
end
