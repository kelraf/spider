defmodule Spider.Repo.Migrations.CreateLivestockOrderStages do
  use Ecto.Migration

  def change do
    create table(:livestock_order_stages) do
      add(:stage_name, :string)
      add(:status, :integer)
      add(:stage_number, :integer)
      add(:description, :string)
      add(:livestock_order_id, references(:livestock_orders, on_delete: :delete_all))

      timestamps()
    end
  end
end
