defmodule Spider.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      
      add :name, :string
      add :type, :string
      add :category, :string
      add :quantity, :integer
      add :units, :string
      add :price, :integer
      add :status, :integer

      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :nothing)

      timestamps()
    end

  end
end
