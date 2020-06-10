defmodule Spider.Repo.Migrations.CreateCCPLOrders do
  use Ecto.Migration

  def change do
    create table(:c_c_p_l_orders) do
      add(:purpose, :string)

      add(:file, :string)
      add(:livestock_order_stage_id, references(:livestock_order_stages, on_delete: :delete_all))

      timestamps()
    end
  end
end
