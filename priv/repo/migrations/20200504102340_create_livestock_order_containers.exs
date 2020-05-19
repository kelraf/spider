defmodule Spider.Repo.Migrations.CreateLivestockOrderContainers do
  use Ecto.Migration

  def change do
    create table(:livestock_order_containers) do

      add :status, :integer
      add :total_cost, :integer
      add :channel, :string
      add :payment_status, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :nothing)

      timestamps()
    end

  end
end
