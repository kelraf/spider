defmodule Spider.Repo.Migrations.CreateProduces do
  use Ecto.Migration

  def change do
    create table(:produces) do
      add :type, :string
      add :category, :string
      add :amount, :integer
      add :units, :string

      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :nothing)

      timestamps()
    end

  end
end
