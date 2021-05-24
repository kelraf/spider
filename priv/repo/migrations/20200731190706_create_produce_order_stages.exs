defmodule Spider.Repo.Migrations.CreateProduceOrderStages do
  use Ecto.Migration

  def change do
    create table(:produce_order_stages) do
      add :stage_name, :string
      add :stage_number, :integer
      add :status, :integer

      add :produce_order_id, references(:produce_orders, on_delete: :delete_all)

      timestamps()
    end

  end
end
