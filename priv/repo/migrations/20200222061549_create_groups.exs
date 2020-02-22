defmodule Spider.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :business_id, references(:businesses, on_delete: :delete_all)
      add :status, :boolean, default: false, null: false

      timestamps()
    end

  end
end
