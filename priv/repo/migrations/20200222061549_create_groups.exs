defmodule Spider.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :delete_all)
      add :status, :integer, default: 0, null: false
      add :role, :integer, default: 2, null: false

      timestamps()
    end

  end
end
