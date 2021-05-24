defmodule Spider.Repo.Migrations.CreateProduces do
  use Ecto.Migration

  def change do
    create table(:produces) do

      add :quantity, :integer
      add :price, :integer
      add :status, :integer

      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :delete_all)
      add :dproduce_id, references(:dproduces, on_delete: :delete_all)

      timestamps()
    end

  end
end
