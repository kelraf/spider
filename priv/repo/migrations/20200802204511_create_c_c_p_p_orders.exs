defmodule Spider.Repo.Migrations.CreateCCPPOrders do
  use Ecto.Migration

  def change do
    create table(:c_c_p_p_orders) do
      add :purpose, :string
      add :file, :string
      add :uuid, :string
      add(:produce_order_stage_id, references(:produce_order_stages, on_delete: :delete_all))

      timestamps()
    end

  end
end
