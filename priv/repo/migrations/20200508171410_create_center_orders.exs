defmodule Spider.Repo.Migrations.CreateCenterOrders do
  use Ecto.Migration

  def change do
    create table(:center_orders) do
      add(:required_animals, :integer)
      add(:available_animals, :integer)
      add(:status, :string)
      add(:description, :string)
      add(:price_per_animal, :integer)
      add(:total_price, :integer)
      add(:who_can_see, {:array, :jsonb})
      add(:total_price_available, :integer)

      add(:livestock_order_id, references(:livestock_orders, on_delete: :delete_all))
      add(:d_livestock_id, references(:dlivestock, on_delete: :delete_all))
      add(:livestock_order_stage_id, references(:livestock_order_stages, on_delete: :delete_all))

      timestamps()
    end
  end
end
