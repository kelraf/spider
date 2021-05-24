defmodule Spider.Repo.Migrations.CreateProduceOrderContainers do
  use Ecto.Migration

  def change do
    create table(:produce_order_containers) do
      
      add :channel, :string
      add :status, :integer
      add :business_from_id, :integer
      add :payment_status, :string

      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :nothing)

      timestamps()
    end

  end
end
