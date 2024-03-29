defmodule Spider.Repo.Migrations.CreateOrdercontainers do
  use Ecto.Migration

  def change do
    create table(:ordercontainers) do

      add :status, :integer
      add :total_cost, :integer
      
      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

  end
end
